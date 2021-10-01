Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3533E41E680
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 06:12:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhJAEOE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 1 Oct 2021 00:14:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44531 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229634AbhJAEOD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 1 Oct 2021 00:14:03 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1914C0Ak024627
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Oct 2021 00:12:00 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1CE5B15C34A8; Fri,  1 Oct 2021 00:12:00 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] ext4: recheck buffer uptodate bit under buffer lock
Date:   Fri,  1 Oct 2021 00:11:58 -0400
Message-Id: <163306150510.267516.9802532504467884977.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210910080316.70421-1-yi.zhang@huawei.com>
References: <20210910080316.70421-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 10 Sep 2021 16:03:16 +0800, Zhang Yi wrote:
> Commit 8e33fadf945a ("ext4: remove an unnecessary if statement in
> __ext4_get_inode_loc()") forget to recheck buffer's uptodate bit again
> under buffer lock, which may overwrite the buffer if someone else have
> already brought it uptodate and changed it.
> 
> 

Applied, thanks!

[1/1] ext4: recheck buffer uptodate bit under buffer lock
      commit: f2c77973507fd116c3657df1dc048864a2b16a1c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
