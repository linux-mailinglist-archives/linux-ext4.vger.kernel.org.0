Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 862274951AB
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jan 2022 16:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376774AbiATPoU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jan 2022 10:44:20 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35101 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1376771AbiATPoU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jan 2022 10:44:20 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20KFiBdj027858
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 10:44:12 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 545C115C41B6; Thu, 20 Jan 2022 10:44:11 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Xin Yin <yinxin.x@bytedance.com>,
        harshadshirwadkar@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] fix blocks allocate issue during fast commit replay
Date:   Thu, 20 Jan 2022 10:44:07 -0500
Message-Id: <164269344019.116615.4300998611120334540.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220110035141.1980-1-yinxin.x@bytedance.com>
References: <20220110035141.1980-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 10 Jan 2022 11:51:39 +0800, Xin Yin wrote:
> when test fast_commit with xfstests generic/455, one failed case is
> after fast commit replay, fsck raise ’multiply-claimed blocks‘ issue.
> one inode's etb block may share with other file.
> 
> fast commit replay procedure may allocate etb blocks for inodes, but
> it may allocate blocks in use. This patch set fix this issue.
> 
> [...]

Applied, thanks!

[1/2] ext4: prevent used blocks from being allocated during fast commit replay
      commit: 8484c37da00dc121c5a9a3613b17a9c0b7b760e1
[2/2] ext4: modify the logic of ext4_mb_new_blocks_simple
      commit: 85c6392fef63e20fa2a3e82383dc57a605d6e5df

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
