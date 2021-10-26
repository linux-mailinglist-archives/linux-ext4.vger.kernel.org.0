Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C333D43B15A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 13:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbhJZLnN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 07:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234803AbhJZLnM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 Oct 2021 07:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635248448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YG+7bmqj0bdTJvSnuX0NifvcRk14pWUa3tcBlnMdyQ0=;
        b=eT4o7eQTDkraQ0xuWw53ux0pCn264wPfS1S2dP2Z8smBI4ygiUelW8mQpnHw5Trdjndv96
        iEq9m3Tt7MOdv1ClxFHaW9XdzR9dHeJmDiTIPOSjLMYn48CH/y7WRbxU8olGsRtXNNYuRs
        gfkwWIM4JZM6fDu6NB+UI/nf33juOrE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-yj3Eou4pPIWjhgObgdSnYg-1; Tue, 26 Oct 2021 07:40:47 -0400
X-MC-Unique: yj3Eou4pPIWjhgObgdSnYg-1
Received: by mail-wr1-f72.google.com with SMTP id d13-20020adf9b8d000000b00160a94c235aso3930669wrc.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Oct 2021 04:40:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YG+7bmqj0bdTJvSnuX0NifvcRk14pWUa3tcBlnMdyQ0=;
        b=pA3LQL0fYgjAveClIfc6PgGNXVvAlQkuLihhMzdIof1pZFlA2Pd25GTG2ewFbQ2Eh4
         X28JBp5MMAjOu8PlaDAeDFGeYQmDHyYWlP2BhdzxBI8qa1oyd5TZ2yE1G7a2orX7rX3K
         IT6mxW+QpdApEe7iaGr/98iCRHDIVmloRs04Tq/qPGdnn/3t/z5AUC14QH85TupVafRk
         c5cD60a464204NawKwU4pcoYQ9wHFwcstbJ7OEFlpnolIPGc2/NZNEWNL5VJyBxucsv7
         7L3e9TyyjB0hvKfphhtVbs2sAtM/FnKsxqWiLjzefhPaf/cterhHa1e4OwI3ITsSOkrX
         8eWg==
X-Gm-Message-State: AOAM530wzxREkDCgwGDq5vNwxItiSd+XUa9Ga9XvqfVfTSleJ1vWe7gQ
        pi2mAEA3Ox5OeT2pfzOpF/S0UvoLysdeMitm0WQbyT4dRlDmGWHQIvuRqWqZFWQAKFbNwlxKuMS
        ka1BDw0IzK2lJybWhp+ZNQQ==
X-Received: by 2002:adf:9b84:: with SMTP id d4mr29282370wrc.393.1635248446093;
        Tue, 26 Oct 2021 04:40:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyh5NH2Zl8AfAUu3h/0LfZdXWteeXUxePDe9u1E82gy5U6kvIUJRNrcrKQgLDScWOLDgmJJGA==
X-Received: by 2002:adf:9b84:: with SMTP id d4mr29282339wrc.393.1635248445901;
        Tue, 26 Oct 2021 04:40:45 -0700 (PDT)
Received: from andromeda.lan (ip4-46-39-172-19.cust.nbox.cz. [46.39.172.19])
        by smtp.gmail.com with ESMTPSA id n17sm417940wms.33.2021.10.26.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 04:40:45 -0700 (PDT)
Date:   Tue, 26 Oct 2021 13:40:43 +0200
From:   Carlos Maiolino <cmaiolino@redhat.com>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 11/13] ext4: change token2str() to use ext4_param_specs
Message-ID: <20211026114043.q5kwobv7vlnv2uej@andromeda.lan>
Mail-Followup-To: Lukas Czerner <lczerner@redhat.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-12-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021114508.21407-12-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 21, 2021 at 01:45:06PM +0200, Lukas Czerner wrote:
> Chage token2str() to use ext4_param_specs instead of tokens so that we

^ Change.

> can get rid of tokens entirely.

If you're removing tokens entirely, maybe the name token2str() doesn't make
sense anymore?

> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  fs/ext4/super.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index bdcaa158eab8..0ccd47f3fa91 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3037,12 +3037,12 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
>  
>  static const char *token2str(int token)
>  {
> -	const struct match_token *t;
> +	const struct fs_parameter_spec *spec;
>  
> -	for (t = tokens; t->token != Opt_err; t++)
> -		if (t->token == token && !strchr(t->pattern, '='))
> +	for (spec = ext4_param_specs; spec->name != NULL; spec++)
> +		if (spec->opt == token && !spec->type)
>  			break;
> -	return t->pattern;
> +	return spec->name;
>  }
>  
>  /*
> -- 
> 2.31.1
> 

-- 
Carlos

