Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0874613DF
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Nov 2021 12:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234805AbhK2Ldb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Nov 2021 06:33:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52190 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234515AbhK2Lbb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Nov 2021 06:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638185293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EB3ov99cOot4oEHHAmAvn4OTPfm97MK2ElTXTKtzC7s=;
        b=fNaUm3R1kcWILno8M3ZSFblN3MuUQXSh1LxOhPCICdv7amA1G4f04/hC+seT3wl45VnobY
        QT46XW5NtuDgry+7raU+AwFYjpsdep8jd0VA8HG2jvgm2ztw/f84VCJkyH4Tk5+VJiHFGl
        YHN/jD3UdMn+JbGXBu2EeOV+7OOE934=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-409-hEP5FGMzNa6MydylqlcNXw-1; Mon, 29 Nov 2021 06:28:09 -0500
X-MC-Unique: hEP5FGMzNa6MydylqlcNXw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 430A11023F4E;
        Mon, 29 Nov 2021 11:28:08 +0000 (UTC)
Received: from work (unknown [10.40.194.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDF0C60BF1;
        Mon, 29 Nov 2021 11:28:06 +0000 (UTC)
Date:   Mon, 29 Nov 2021 12:28:03 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] ext4: Destroy ext4_fc_dentry_cachep kmemcache on module
 removal.
Message-ID: <20211129112803.tdm75zscdadsiul4@work>
References: <20211110134640.lyku5vklvdndw6uk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211110134640.lyku5vklvdndw6uk@linutronix.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 10, 2021 at 02:46:40PM +0100, Sebastian Andrzej Siewior wrote:
> The kmemcache for ext4_fc_dentry_cachep remains registered after module
> removal.
> 
> Destroy ext4_fc_dentry_cachep kmemcache on module removal.

Thanks! It looks good to me.

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

> 
> Fixes: aa75f4d3daaeb ("ext4: main fast-commit commit path")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  fs/ext4/ext4.h        | 1 +
>  fs/ext4/fast_commit.c | 5 +++++
>  fs/ext4/super.c       | 2 ++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 3825195539d74..c97860ef322db 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2934,6 +2934,7 @@ bool ext4_fc_replay_check_excluded(struct super_block *sb, ext4_fsblk_t block);
>  void ext4_fc_replay_cleanup(struct super_block *sb);
>  int ext4_fc_commit(journal_t *journal, tid_t commit_tid);
>  int __init ext4_fc_init_dentry_cache(void);
> +void ext4_fc_destroy_dentry_cache(void);
>  
>  /* mballoc.c */
>  extern const struct seq_operations ext4_mb_seq_groups_ops;
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 8ea5a81e65548..1a43af302ecba 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -2185,3 +2185,8 @@ int __init ext4_fc_init_dentry_cache(void)
>  
>  	return 0;
>  }
> +
> +void ext4_fc_destroy_dentry_cache(void)
> +{
> +	kmem_cache_destroy(ext4_fc_dentry_cachep);
> +}
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88d5d274a8684..eb2dfc2a19d33 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6641,6 +6641,7 @@ static int __init ext4_init_fs(void)
>  out:
>  	unregister_as_ext2();
>  	unregister_as_ext3();
> +	ext4_fc_destroy_dentry_cache();
>  out05:
>  	destroy_inodecache();
>  out1:
> @@ -6667,6 +6668,7 @@ static void __exit ext4_exit_fs(void)
>  	unregister_as_ext2();
>  	unregister_as_ext3();
>  	unregister_filesystem(&ext4_fs_type);
> +	ext4_fc_destroy_dentry_cache();
>  	destroy_inodecache();
>  	ext4_exit_mballoc();
>  	ext4_exit_sysfs();
> -- 
> 2.33.1
> 

