Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E38269BEA4
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBSFlh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjBSFl2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:28 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D0613DE5
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:26 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5ewW5024894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785260; bh=Go/S8rqoShARsQkpOiU9pxkU0pFSWHJZHUuY4ThVyS0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=UgxdAkaBMFqbAFgJDnQLC2OcOjjbD4LRhxdfWAOD+ek3/4mebh/D7TcKCEstqVaIT
         tbe9gnx7RtSricHyK5+zCBKhr3k7DBbpVZQb7msIVv9kgoGTHAcI85BlTx8Uh3Veg9
         lhQgv9m8szTS1wOH9+aLXuguLfpAs/Bt9z5CMPb1EMyu3lEc1bYTJLF/RZAqoksL5E
         qpdycZCsb04LIQYFPPvjTiBgPldcAvlV/fvFnqlkevsLnROJtOXTnOi9vAxkSAJwjk
         sLbC8xRyNlcYxebV6tlclXSOSZZpyrdyXbAjRcmCqF0FjIV7Y5FkDA/Ybj7NBovl0U
         b4s+XPYo1SUmA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D0BC215C35AB; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        Ye Bin <yebin10@huawei.com>, jack@suse.cz
Subject: Re: [PATCH] ext4: init error handle resource before init group descriptors
Date:   Sun, 19 Feb 2023 00:40:51 -0500
Message-Id: <167678522174.2723470.13391840576077064644.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230119013711.86680-1-yebin@huaweicloud.com>
References: <20230119013711.86680-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 19 Jan 2023 09:37:11 +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, 's_err_report' timer is init after ext4_group_desc_init() when fill
> super. Theoretically, ext4_group_desc_init() may access to error handle
> as follows:
> __ext4_fill_super
>   ext4_group_desc_init
>     ext4_check_descriptors
>       ext4_get_group_desc
>         ext4_error
>           ext4_handle_error
>             ext4_commit_super
>               ext4_update_super
>                 if (!es->s_error_count)
>                   mod_timer(&sbi->s_err_report, jiffies + 24*60*60*HZ);
> 		  --> Accessing Uninitialized Variables
> timer_setup(&sbi->s_err_report, print_daily_error_info, 0);
> 
> [...]

Applied, thanks!

[1/1] ext4: init error handle resource before init group descriptors
      commit: 2806abcc97829d49172632db81deac9119641b78

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
