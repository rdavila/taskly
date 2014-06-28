module Task::SessionStates
  extend ActiveSupport::Concern

  FINISHED_STATE = 'finished'
  RUNNING_STATE  = 'running'
  STATES         = [FINISHED_STATE, RUNNING_STATE]

  included do
    STATES.each do |state|
      scope state.to_sym, -> { where(state: state) }

      define_method "#{state}?" do
        self.state == state
      end

      define_method "mark_as_#{state}".to_sym do
        self.state = state
      end
    end
  end

end
