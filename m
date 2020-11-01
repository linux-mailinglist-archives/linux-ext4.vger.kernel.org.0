Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBDEF2A1C84
	for <lists+linux-ext4@lfdr.de>; Sun,  1 Nov 2020 08:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgKAHJg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 1 Nov 2020 02:09:36 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37228 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgKAHJf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 1 Nov 2020 02:09:35 -0500
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1kZ7Ua-0002Xi-Qj
        for linux-ext4@vger.kernel.org; Sun, 01 Nov 2020 07:09:32 +0000
Received: by mail-wr1-f69.google.com with SMTP id 33so4855602wrf.22
        for <linux-ext4@vger.kernel.org>; Sun, 01 Nov 2020 00:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KEF81+W/RDv8uEWz0hWR7cCQN57HgriMw8kAcFsgqaM=;
        b=pInjIp6ch5yaUIAVhPYqPcEryYkAUjS15JK+/oYsFftzpwz03hMEyQb5gLZhqov/L+
         WPFQ+6EpxiUEvjgC97Zn2p+cAQm82HNV2PLq0PEWR28Vk+oLvuHXHq2zHSoqY8uz0BkT
         zAt3snO96qMP2eBN04lTaVk8ib0/r+ZAyDlR1gqRqoq64IFifuKzNkm0RLpcVZ0tlGMg
         +uowLqaWMNo3xFRr2mWZdobI70p2fKykSE60l88opvF5IYleRzmWaGSeWFpazmB61em4
         QaMREOHGF4vDsMyD+75WuGDSawDftLvIX04YkkWmH2D1owQ49kNHzWfBJ4TNs+R2UxCb
         d9Ow==
X-Gm-Message-State: AOAM530spH4WEA2d/1PenP1uMztJJl2bdYs8D4+TAs+ldfZ4v9y+Iqde
        IV0nU5mz32WpOtzEb98Bx1f9hz8dOzDoYRGhyRquxZdPL02LRvCvnW2IdEC1R3WEO/Vvar+x7Jd
        AmUx4MxHRK93xY8d241ijKJUZedAXFvxYvhBo2RU=
X-Received: by 2002:a7b:c055:: with SMTP id u21mr11257293wmc.27.1604214572164;
        Sun, 01 Nov 2020 00:09:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzr194OE8mnY4u+DnDxdHAAowkExXwxpWyez3Jyo5wgFbJuNLfiuTYb789KemCBZCFV/L4NQ==
X-Received: by 2002:a7b:c055:: with SMTP id u21mr11257271wmc.27.1604214571934;
        Sun, 01 Nov 2020 00:09:31 -0700 (PDT)
Received: from localhost (host-79-33-123-6.retail.telecomitalia.it. [79.33.123.6])
        by smtp.gmail.com with ESMTPSA id p4sm18089355wrf.67.2020.11.01.00.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2020 00:09:31 -0700 (PDT)
Date:   Sun, 1 Nov 2020 08:09:29 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 08/10] ext4: fix inode dirty check in case of fast commits
Message-ID: <20201101070929.GA3989@xps-13-7390>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-9-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-9-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Oct 31, 2020 at 01:05:16PM -0700, Harshad Shirwadkar wrote:
> In case of fast commits, determine if the inode is dirty by checking
> if the inode is on fast commit list. This also helps us get rid of
> ext4_inode_info.i_fc_committed_subtid field.
> 
> Reported-by: Andrea Righi <andrea.righi@canonical.com>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Tested and looks good to me. Thanks Harshad!

Tested-by: Andrea Righi <andrea.righi@canonical.com>

> ---
>  fs/ext4/ext4.h        | 3 ---
>  fs/ext4/fast_commit.c | 3 ---
>  fs/ext4/inode.c       | 3 +--
>  3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 573db158382f..7222a9ba5d66 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1028,9 +1028,6 @@ struct ext4_inode_info {
>  					 * protected by sbi->s_fc_lock.
>  					 */
>  
> -	/* Fast commit subtid when this inode was committed */
> -	unsigned int i_fc_committed_subtid;
> -
>  	/* Start of lblk range that needs to be committed in this fast commit */
>  	ext4_lblk_t i_fc_lblk_start;
>  
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index b7b1fe6dbb24..4c0a3e858ea3 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -152,7 +152,6 @@ void ext4_fc_init_inode(struct inode *inode)
>  	INIT_LIST_HEAD(&ei->i_fc_list);
>  	init_waitqueue_head(&ei->i_fc_wait);
>  	atomic_set(&ei->i_fc_updates, 0);
> -	ei->i_fc_committed_subtid = 0;
>  }
>  
>  static void ext4_fc_wait_committing_inode(struct inode *inode)
> @@ -1026,8 +1025,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  		if (ret)
>  			goto out;
>  		spin_lock(&sbi->s_fc_lock);
> -		EXT4_I(inode)->i_fc_committed_subtid =
> -			atomic_read(&sbi->s_fc_subtid);
>  	}
>  	spin_unlock(&sbi->s_fc_lock);
>  
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7f6af784e74f..d36c3908272f 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -3311,8 +3311,7 @@ static bool ext4_inode_datasync_dirty(struct inode *inode)
>  			EXT4_I(inode)->i_datasync_tid))
>  			return false;
>  		if (test_opt2(inode->i_sb, JOURNAL_FAST_COMMIT))
> -			return atomic_read(&EXT4_SB(inode->i_sb)->s_fc_subtid) <
> -				EXT4_I(inode)->i_fc_committed_subtid;
> +			return !list_empty(&EXT4_I(inode)->i_fc_list);
>  		return true;
>  	}
>  
> -- 
> 2.29.1.341.ge80a0c044ae-goog
