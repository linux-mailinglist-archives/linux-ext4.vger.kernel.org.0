Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BE643B201
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Oct 2021 14:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235153AbhJZMM1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 26 Oct 2021 08:12:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47473 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235152AbhJZMM0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 26 Oct 2021 08:12:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635250202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VFu990jGZuZSQ6puNWxAX6hSr0vpbWIv4s14VxM/J+U=;
        b=e4R/K58/3e7GBErkSECyOj45PbkbXI3Rp0+MwBiZpILpDWmRBcL7A6rYQv1cS3Zqpt2IR6
        f7mWf34Biv26xiAifZVocC65ON2gJtJKuft0u7ph96HtdBFHppoKXSCo/VuobbZQy6S9kO
        jgyfmicLJvdhTpl35Pt4jIC0TKNkXd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-8VX1YcmkO1WPMoyKKk9vlA-1; Tue, 26 Oct 2021 08:09:59 -0400
X-MC-Unique: 8VX1YcmkO1WPMoyKKk9vlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 63D1E806690;
        Tue, 26 Oct 2021 12:09:58 +0000 (UTC)
Received: from work (unknown [10.40.194.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 740B3641AA;
        Tue, 26 Oct 2021 12:09:57 +0000 (UTC)
Date:   Tue, 26 Oct 2021 14:09:53 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 11/13] ext4: change token2str() to use ext4_param_specs
Message-ID: <20211026120953.mropvelvr4id7mej@work>
References: <20211021114508.21407-1-lczerner@redhat.com>
 <20211021114508.21407-12-lczerner@redhat.com>
 <20211026114043.q5kwobv7vlnv2uej@andromeda.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026114043.q5kwobv7vlnv2uej@andromeda.lan>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 26, 2021 at 01:40:43PM +0200, Carlos Maiolino wrote:
> On Thu, Oct 21, 2021 at 01:45:06PM +0200, Lukas Czerner wrote:
> > Chage token2str() to use ext4_param_specs instead of tokens so that we
> 
> ^ Change.
> 
> > can get rid of tokens entirely.
> 
> If you're removing tokens entirely, maybe the name token2str() doesn't make
> sense anymore?

True, I guess it's no longer called "token" so maybe option2str() ?

-Lukas

> 
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  fs/ext4/super.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index bdcaa158eab8..0ccd47f3fa91 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -3037,12 +3037,12 @@ static inline void ext4_show_quota_options(struct seq_file *seq,
> >  
> >  static const char *token2str(int token)
> >  {
> > -	const struct match_token *t;
> > +	const struct fs_parameter_spec *spec;
> >  
> > -	for (t = tokens; t->token != Opt_err; t++)
> > -		if (t->token == token && !strchr(t->pattern, '='))
> > +	for (spec = ext4_param_specs; spec->name != NULL; spec++)
> > +		if (spec->opt == token && !spec->type)
> >  			break;
> > -	return t->pattern;
> > +	return spec->name;
> >  }
> >  
> >  /*
> > -- 
> > 2.31.1
> > 
> 
> -- 
> Carlos
> 

