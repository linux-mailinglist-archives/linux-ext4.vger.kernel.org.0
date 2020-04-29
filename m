Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A052C1BDA39
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 13:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgD2LCT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 07:02:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24074 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2LCT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Apr 2020 07:02:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588158138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XqC41x4PruaAPU1YcSPW9WP4aeY86SVarTK6qniLX78=;
        b=eUgXD3mXVwZdgkfCQX+tXmmX8+NYoU5SIFkzEKtlXKEUgPda87a6C9b7BJDKxuGFBQCxv/
        NjCrLBbY+WFrclbwSO1GSzT8Fp9pcnouG+gIFpsp7uGeSsDLrKNINStrDW7Z1K0e2XHdLL
        fFQO6TEultH4Kmi3e8pgUaocVLyMLXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-imo-K3UIMOuqgVGu1uhLLA-1; Wed, 29 Apr 2020 07:02:14 -0400
X-MC-Unique: imo-K3UIMOuqgVGu1uhLLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38768107ACCA;
        Wed, 29 Apr 2020 11:02:13 +0000 (UTC)
Received: from work (unknown [10.40.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9E24150FE2;
        Wed, 29 Apr 2020 11:02:11 +0000 (UTC)
Date:   Wed, 29 Apr 2020 13:02:07 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     linux-ext4@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2 05/17] ext4: Allow sb to be NULL in ext4_msg()
Message-ID: <20200429110207.cvvxn4szl7d36a4x@work>
References: <20200428164536.462-1-lczerner@redhat.com>
 <20200428164536.462-6-lczerner@redhat.com>
 <39a487d3-bce3-0290-229a-c49a540ba7de@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39a487d3-bce3-0290-229a-c49a540ba7de@sandeen.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 09:38:11PM -0500, Eric Sandeen wrote:
> On 4/28/20 11:45 AM, Lukas Czerner wrote:
> > At the parsing phase of mount in the new mount api sb will not be
> > available so allow sb to be NULL in ext4_msg and use that in
> > handle_mount_opt().
> > 
> > Also change return value to appropriate -EINVAL where needed.
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  fs/ext4/super.c | 120 +++++++++++++++++++++++++-----------------------
> >  1 file changed, 63 insertions(+), 57 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 2c6fea451d7d..2f7e49bfbf71 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -88,7 +88,7 @@ static void ext4_unregister_li_request(struct super_block *sb);
> >  static void ext4_clear_request_list(void);
> >  static struct inode *ext4_get_journal_inode(struct super_block *sb,
> >  					    unsigned int journal_inum);
> > -static int ext4_validate_options(struct super_block *sb);
> > +static int ext4_validate_options(struct fs_context *fc);
> >  
> >  /*
> >   * Lock ordering
> > @@ -754,13 +754,14 @@ void __ext4_msg(struct super_block *sb,
> >  	struct va_format vaf;
> >  	va_list args;
> >  
> > -	if (!___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
> > +	if (sb &&
> > +	    !___ratelimit(&(EXT4_SB(sb)->s_msg_ratelimit_state), "EXT4-fs"))
> >  		return;
> >  
> >  	va_start(args, fmt);
> >  	vaf.fmt = fmt;
> >  	vaf.va = &args;
> > -	printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
> > +	printk("%sEXT4-fs (%s): %pV\n", prefix, sb ? sb->s_id : "n/a", &vaf);
> 
> Tiny nitpick, I might drop "n/a" - I'm not sure that makes anything clearer:
> 
> "EXT4-fs (n/a): message" seems confusing, but maybe that's just me.
> 
> FWIW xfs just removes the s_id print altogether if it's not available, i.e.:
> 
> static void
> __xfs_printk(
>         const char              *level,
>         const struct xfs_mount  *mp,
>         struct va_format        *vaf)
> {
>         if (mp && mp->m_super) {
>                 printk("%sXFS (%s): %pV\n", level, mp->m_super->s_id, vaf);
>                 return;
>         }
>         printk("%sXFS: %pV\n", level, vaf);
> }
> 
> *shrug* up to personal preference I suppose.

I wanted the message to stay more-or-less uniform, but I think you're
right. I'll drop the (n/a).

-Lukas

> 
> Thanks,
> -Eric
> 

