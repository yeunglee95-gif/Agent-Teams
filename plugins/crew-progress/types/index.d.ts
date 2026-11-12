export type Phase = 'plan' | 'design' | 'delegate' | 'review' | 'close'

export type PlannedTask = {
  title: string
  tier: string
  after: number[]
}

export type Flow = {
  title: string
  total: number
  done: number
  running: number
  phase: Phase
  isFinished: boolean
  tasks: PlannedTask[]
}

export type AgentStatus = 'running' | 'done' | 'failed'

export type AgentRun = {
  id: string
  agentId?: string
  type: string
  description: string
  model: string
  effort?: string
  status: AgentStatus
  startedAt: number
  endedAt?: number
  contextTokens: number
  contextMax: number
  tokens: number
  costUsd: number
  steps: number
  round: number
  /** Self-reported by the worker through the `step` tool. */
  stepDone?: number
  stepTotal?: number
  stepNote?: string
}

export type Panel = {
  isCompact: boolean
  isDoneCollapsed: boolean
  autoOpenedFor: string
}

export type CodexTask = {
  id: string
  brief: string
  role: string
  model: string
  cwd: string
  isRunning: boolean
  lastLine: string
  steps: number
  tokens: number
  startedMs: number
  updatedMs: number
}

export type CodexLimits = {
  plan: string
  fiveHourPct: number
  fiveHourResets: number
  weekPct: number
  weekResets: number
  seenMs: number
}

export type CodexView = { tasks: CodexTask[]; limits: CodexLimits | null }

declare module 'claude-code' {
  interface PluginState {
    'crew-progress': {
      flow: Flow | null
      agents: AgentRun[]
      panel: Panel
      now: number
      codex: CodexView
    }
  }
}
