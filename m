Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A701241E03B
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Sep 2021 19:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352739AbhI3ReU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 13:34:20 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:48726 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1352732AbhI3ReU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 13:34:20 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 18UHWWMU014210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 13:32:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E3EFF15C35F3; Thu, 30 Sep 2021 13:32:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/8] quota: Add support to version 0 quota format
Date:   Thu, 30 Sep 2021 13:32:29 -0400
Message-Id: <163302312656.115797.16598621394418062920.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210823154128.16615-2-jack@suse.cz>
References: <20210823154128.16615-1-jack@suse.cz> <20210823154128.16615-2-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 23 Aug 2021 17:41:21 +0200, Jan Kara wrote:
> Version 0 quota format differs from version 1 by having only 32-bit
> counters for inodes and block limits. For many installations this is not
> limiting and thus the format is widely used. Also quota tools still
> create quota files with this format by default. Add support for this
> quota format to e2fsprogs so that we can seamlessly convert quota files
> in this format into our internal quota files.
> 
> [...]

Applied, thanks!

[1/8] quota: Add support to version 0 quota format
      (no commit info)
[2/8] quota: Fold quota_read_all_dquots() into quota_update_limits()
      (no commit info)
[3/8] quota: Rename quota_update_limits() to quota_read_all_dquots()
      (no commit info)
[4/8] tune2fs: Fix conversion of quota files
      (no commit info)
[5/8] e2fsck: Do not trash user limits when processing orphan list
      (no commit info)
[6/8] tests: Expand test checking quota and orphan processing interaction
      (no commit info)
[7/8] debugfs: Fix headers for quota commands
      (no commit info)
[8/8] quota: Drop dead code
      (no commit info)

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
