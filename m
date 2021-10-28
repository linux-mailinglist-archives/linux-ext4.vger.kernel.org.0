Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5E643E425
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 16:47:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhJ1Otx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Oct 2021 10:49:53 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37395 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231211AbhJ1Otx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Oct 2021 10:49:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19SElCU9031172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 10:47:13 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8030C15C00B9; Thu, 28 Oct 2021 10:47:12 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH v5 0/3] ext4: fix a inode checksum error
Date:   Thu, 28 Oct 2021 10:47:11 -0400
Message-Id: <163543241900.1888535.1502042534109061590.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210901020955.1657340-1-yi.zhang@huawei.com>
References: <20210901020955.1657340-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 1 Sep 2021 10:09:52 +0800, Zhang Yi wrote:
> We find a checksum error and a inode corruption problem while doing
> stress test, this 3 patches address to fix them. The first two patches
> are prepare to do the fix, the last patch fix these two issue.
> 
>  - Checksum error
> 
>     EXT4-fs error (device sda): ext4_lookup:1784: inode #131074: comm cat: iget: checksum invalid
> 
> [...]

Applied, thanks!

[1/3] ext4: factor out ext4_fill_raw_inode()
      commit: 6a6af6b5ee4363e29fc86552ddfd94c5000d845d
[2/3] ext4: move ext4_fill_raw_inode() related functions
      commit: 4bc2b511975a6fe5ce9f2b2dcc84b152354d1f90
[3/3] ext4: prevent getting empty inode buffer
      commit: fb5becb151d54652ae613e34157f1aadb8447ed8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
