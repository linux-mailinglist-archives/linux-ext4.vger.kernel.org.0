Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26C4830BC
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jan 2022 12:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbiACLtl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jan 2022 06:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229788AbiACLtk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jan 2022 06:49:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641210580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2W3BHwBpNpujMTuCJvmRQWjBfRoPnEfYjaEvRBQoJ4=;
        b=FBgY7GtFojovEFJqCOprv4By71+SkjYZpLxYAbCVGoDykACZx4YZcv1Bw/+GUABGsrKIaK
        TGM8FIv3wce3yUgI5BA862opWlE+jNf9McJtSc8zSgVoh7OIUMLAC0f6M9hS+6hUU9Bm/w
        nQgRHOImeu+3aM1VfDjtXmIu8BPr2P8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-179-CVNj7gYqNfSj-RVt85_y8w-1; Mon, 03 Jan 2022 06:49:37 -0500
X-MC-Unique: CVNj7gYqNfSj-RVt85_y8w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DCCBB100CCC0;
        Mon,  3 Jan 2022 11:49:35 +0000 (UTC)
Received: from work (unknown [10.40.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2F357E22E;
        Mon,  3 Jan 2022 11:49:34 +0000 (UTC)
Date:   Mon, 3 Jan 2022 12:49:31 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [tytso-ext4:dev] BUILD REGRESSION
 cc5fef71a1c741473eebb1aa6f7056ceb49bc33d
Message-ID: <20220103114931.uup7lw3d4pj7yrrx@work>
References: <61c73848.ezrkzdC4STslya5j%lkp@intel.com>
 <YckTD4NcqD8rdZDV@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YckTD4NcqD8rdZDV@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Dec 26, 2021 at 08:12:47PM -0500, Theodore Ts'o wrote:
> On Sat, Dec 25, 2021 at 11:27:04PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git dev
> > branch HEAD: cc5fef71a1c741473eebb1aa6f7056ceb49bc33d  ext4: replace snprintf in show functions with sysfs_emit
> > 
> > Error/Warning reports:
> > 
> > https://lore.kernel.org/linux-ext4/202112101722.3Kpomg0h-lkp@intel.com
> > 
> > possible Error/Warning in current branch (please contact us if interested):
> > 
> > fs/ext4/super.c:2640:22-40: ERROR: reference preceded by free on line 2639
> 
> The Intel test robot mis-identified the commit which introduced this
> problem (it looks like the first commit with the problem is commit
> e6e268cb6822 ("ext4: move quota configuration out of
> handle_mount_opt()"), but it caused me to take a closer look, and this
> looks... wrong.
> 
> From ext4_apply_quota_options() in fs/extr4/super.c:
> 
> 			qname = ctx->s_qf_names[i]; /* May be NULL */
> 			ctx->s_qf_names[i] = NULL;
> 			kfree(sbi->s_qf_names[i]);
> 			rcu_assign_pointer(sbi->s_qf_names[i], qname);
> 			set_opt(sb, QUOTA);
> 
> sbi->s_qf_names[i] is an RCU protected pointer, which is used via
> rcu_derference().  So how can it be safe to kfree() the pointer;
> should that be kfree_rcu() at the very least?
> 
> Lukas, can you take a look and let me know?   Thanks!
> 
>        	       	      	       	      - Ted

Hi Ted,

yes indeed this is a bug. Something like this untested patch should fix
it I believe.

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b72d989b77fb..6f52609a334c 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2633,8 +2633,10 @@ static void ext4_apply_quota_options(struct fs_context *fc,

                        qname = ctx->s_qf_names[i]; /* May be NULL */
                        ctx->s_qf_names[i] = NULL;
-                       kfree(sbi->s_qf_names[i]);
-                       rcu_assign_pointer(sbi->s_qf_names[i], qname);
+                       qname = rcu_replace_pointer(sbi->s_qf_names[i], qname,
+                                               lockdep_is_held(&sb->s_umount));
+                       if (qname)
+                               kfree_rcu(qname);
                        set_opt(sb, QUOTA);
                }
        }


There is also a question of the other warning where we pass the pointer
to strcmp which we should silence as well. I'll send a proper patch.

Thanks!
-Lukas

