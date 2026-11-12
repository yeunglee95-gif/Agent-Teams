import { describe, expect, mock, test } from 'claude-code/testing'
import type { On } from 'claude-code'

// Codex's session logs and the status file are found from the user's home, never from a fixed /root.
type Seen = { exists: string[]; listed: string[]; written: Record<string, string> }

const ROLLOUT = [
  { type: 'session_meta', timestamp: '2026-11-12T10:00:00Z', payload: { cwd: '/work/app', timestamp: '2026-11-12T10:00:00Z' } },
  { type: 'event_msg', payload: { type: 'task_started' } },
  { type: 'response_item', payload: { type: 'message', role: 'user', content: [{ text: 'Fix the parser as the fixer' }] } },
].map(l => JSON.stringify(l)).join('\n')

function world(on: On, env: Record<string, string>, home: string): Seen {
  const seen: Seen = { exists: [], listed: [], written: {} }
  const sessions = `${home}/.codex/sessions`
  const dirs: Record<string, [string, 'dir' | 'file'][]> = {
    [sessions]: [['2026', 'dir']],
    [`${sessions}/2026`]: [['11', 'dir']],
    [`${sessions}/2026/11`]: [['12', 'dir']],
    [`${sessions}/2026/11/12`]: [['rollout-abc.jsonl', 'file']],
  }
  mock.env(on, env)
  mock.clock(on, { now: Date.now() })
  mock.store(on)
  on('session.start', (_$, e) => ({ cwd: e.cwd }))
  on('settings.read', () => ({ value: {} }))
  on('tool.register', () => ({ value: undefined }) as never)
  on('command.register', (_$, e) => ({ value: { command: e.name } }))
  on('ui.open', () => ({ value: { isPlaced: true } }))
  on('fs.exists', (_$, e) => {
    seen.exists.push(e.path)
    return { value: dirs[e.path] !== undefined }
  })
  on('fs.list', (_$, e) => {
    seen.listed.push(e.path)
    const kids = dirs[e.path]
    if (!kids) throw new Error(`ENOENT ${e.path}`)
    return { value: kids.map(([name, kind]) => ({ name, kind, size: 1, mtimeMs: Date.now(), isLink: false })) }
  })
  on('fs.read', (_$, e) => {
    if (e.path === `${sessions}/2026/11/12/rollout-abc.jsonl`) return { value: ROLLOUT }
    throw new Error(`ENOENT ${e.path}`)
  })
  on('fs.write', (_$, e) => {
    seen.written[e.path] = e.text
    return { value: undefined }
  })
  return seen
}

async function settle(check: () => boolean) {
  for (let i = 0; i < 100 && !check(); i++) await new Promise(r => setTimeout(r, 10))
}
declare const setTimeout: (fn: (...args: never[]) => void, ms: number) => unknown

describe('crew-progress paths', () => {
  test('reads Codex logs and writes the status file under HOME', async ($, on) => {
    const seen = world(on, { HOME: '/home/test' }, '/home/test')
    await $.session.start({ cwd: '/work/app', surface: 'terminal', isInteractive: true } as never)
    await settle(() => Object.keys(seen.written).length > 0)
    expect(seen.exists).toContain('/home/test/.codex/sessions')
    expect(Object.keys(seen.written)).toEqual(['/home/test/.claude/state/crew-progress/status.md'])
    expect(seen.written['/home/test/.claude/state/crew-progress/status.md']).toContain('Codex: 1 running')
    expect([...seen.exists, ...seen.listed].some(p => p.startsWith('/root'))).toBe(false)
  })

  test('falls back to USERPROFILE when HOME is unset', async ($, on) => {
    const seen = world(on, { USERPROFILE: '/users/test' }, '/users/test')
    await $.session.start({ cwd: '/work/app', surface: 'terminal', isInteractive: true } as never)
    await settle(() => Object.keys(seen.written).length > 0)
    expect(Object.keys(seen.written)).toEqual(['/users/test/.claude/state/crew-progress/status.md'])
  })
})
