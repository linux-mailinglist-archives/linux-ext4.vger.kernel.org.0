Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728A64951AD
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jan 2022 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376736AbiATPoY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jan 2022 10:44:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35111 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1376782AbiATPoY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jan 2022 10:44:24 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20KFiCYi027868
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 10:44:12 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2477E15C41B7; Thu, 20 Jan 2022 10:44:12 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Xin Yin <yinxin.x@bytedance.com>,
        harshadshirwadkar@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        dan.carpenter@oracle.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] ext4: fix issues when fast commit work with jbd
Date:   Thu, 20 Jan 2022 10:44:08 -0500
Message-Id: <164269344020.116615.10466472564814944952.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220117093655.35160-1-yinxin.x@bytedance.com>
References: <20220117093655.35160-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 17 Jan 2022 17:36:53 +0800, Xin Yin wrote:
> When test fast commit with xfstests generic/455, some logic issues were
> found. When a full commit is ongonig, the logic of fast commit tracking seems
> not correct. The first patch fix the ineligible commit case , and the
> second patch fix the common fast commit case.
> 
> After testing this patch set with xfstests log and quick group, no
> regressions were found, and the generic/455 can pass now.
> 
> [...]

Applied, thanks!

[1/2] ext4: fast commit may not fallback for ineligible commit
      commit: b4facf2d8a22262f945975d23e29bbfa94ab5d27
[2/2] ext4: fast commit may miss file actions
      commit: 4a404adb1978f0a3f2ec9ee6c257bcc5b2452ee3

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
