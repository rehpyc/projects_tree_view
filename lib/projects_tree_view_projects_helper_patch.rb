module ProjectsTreeView
  module ProjectsHelperPatch
    extend ActiveSupport::Concern

    module ClassMethods
    end

    def progress_statices(project)
      condition = project.project_condition(false)
      statics   = { } 
      statics[:total ] = project.issues.count
      statics[:open  ] = Issue.visible.includes(:project, :status).where(["(#{ condition }) AND #{IssueStatus.table_name}.is_closed=?", false]).references(:project, :status).count
      statics[:closed] = statics[:total] - statics[:open]
      statics[:rate  ] = (1 - statics[:open].to_f / statics[:total ]) * 100
      return statics
    end

  end
end
