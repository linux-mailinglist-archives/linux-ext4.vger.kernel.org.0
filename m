Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD64958FE62
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Aug 2022 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbiHKOdv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Aug 2022 10:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiHKOdd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Aug 2022 10:33:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5A90804
        for <linux-ext4@vger.kernel.org>; Thu, 11 Aug 2022 07:32:50 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-49-209-117.bstnma.fios.verizon.net [108.49.209.117])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 27BEWdj1008257
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Aug 2022 10:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1660228361; bh=T3lw3IwuhHA1V3l/MYu1vYpjMuXu8N7ksEJFH9isv00=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ahZ2TSz6315umeJwSp975+vyYxhvjhx1rJr+UU7P6VUYuXiPExYXoeHunSLdahCTS
         v1byVc0YIzj+Bxdp2uFvYoJx1p3JDGac4dE3fYMSibokwmm/IJDmLCNTbeBVfT8UzM
         ijsxZyAnJUDXbXiWnnE9vQcEuHCZ4lZ5FLTWyyDUvcC43RhNDnwZRpgDMeLQXNNDw1
         b3GL5XU5G3IKDT4BdNVDImNU1KxtRw91J1B6e92aV8zF+Jl7vk3an/nDW7C7q82M3r
         tI11I1vE5/XNwKmWkaDMbXc4nv3rizx/ew+vBOKdhrBRz2xUkCHi3nAKMMh7Z42zVZ
         VcweEdHuOGBpg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8054B15C41BC; Thu, 11 Aug 2022 10:32:38 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger@whamcloud.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, dongyangli@ddn.com,
        linux-ext4@vger.kernel.org, artem.blagodarenko@hpe.com
Subject: Re: [PATCH] tests: fix ACL-printing tests
Date:   Thu, 11 Aug 2022 10:32:34 -0400
Message-Id: <166022767028.3024810.2294080437723088286.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220301041706.75079-1-adilger@whamcloud.com>
References: <20220301041706.75079-1-adilger@whamcloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 28 Feb 2022 21:17:06 -0700, Andreas Dilger wrote:
> Fix the ACL-printing tests to be more flexible for different systems.
> If the MKFS_DIR is on tmpfs, it will not list "system.posix_acl*"
> xattrs, so they will not be copied.  Create this on a real filesystem
> or skip the test if that doesn't work.
> 
> Filter out the security.selinux xattr if it is printed, since this
> depends on the selinux configuration of the host system.  However,
> this also spills xattrs for "acl_dir/file" into an external xattr
> block, and causes it to fail due to different block allocations.
> Increase the filesystem inode size so that the allocation is the same
> regardless of whether selinux is enabled or not.
> 
> [...]

Applied, thanks!

[1/1] tests: fix ACL-printing tests
      commit: 13f1ce96046fba15d93a90733b791312284fbb62

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
