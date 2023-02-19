Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE52069BEAB
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjBSFmC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:42:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBSFlr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:47 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B319C14234
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:31 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5ewaN024899
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785260; bh=ZWg3MIgPYlHwhuQ3ZZvG1yz+8gII+IfK+0vIJYCSEfw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KCi4PUWExNS27jJjWC+hy7wqEfaH/5PY8Wd0rCJ0FNs3YmhqCKO4GLjx08tN/sSrC
         ZDZSr4leZCXcYHUg1+ilizjpupuy4Q7dJYwutpigkXN1OenFqMeeQBgBqP2dMbbdSa
         PXdWH+Yv4sUYhVhbkXIolCvENTsU2u4uSShX/xreGqvkf+ukux7tm9PCGMVmeFaw30
         D+d/bzB1g5F2Cnnu14oVW7U+xAdOj2Q1/ai6C2/5nOBCwR8gjG/sXIGZGTCup/rIZa
         T4w9y2Llhwj8o7sC0YzxILbuBQrzvRn8DGFhE+0ZKgxF/aY6+PK33YFLoG1S/G2GnN
         qJv/ZoT9fyLQw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D267E15C35AD; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, harshadshirwadkar@gmail.com,
        yukuai3@huawei.com, jack@suse.cz, adilger.kernel@dilger.ca,
        yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: fix incorrect options show of original mount_opt and extend mount_opt2
Date:   Sun, 19 Feb 2023 00:40:52 -0500
Message-Id: <167678522175.2723470.947251130041541201.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230129034939.3702550-1-yi.zhang@huaweicloud.com>
References: <20230129034939.3702550-1-yi.zhang@huaweicloud.com>
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

On Sun, 29 Jan 2023 11:49:39 +0800, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Current _ext4_show_options() do not distinguish MOPT_2 flag, so it mixed
> extend sbi->s_mount_opt2 options with sbi->s_mount_opt, it could lead to
> show incorrect options, e.g. show fc_debug_force if we mount with
> errors=continue mode and miss it if we set.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix incorrect options show of original mount_opt and extend mount_opt2
      commit: 2c2dec1e86cc43266e084a8782f91613d52eeddf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
