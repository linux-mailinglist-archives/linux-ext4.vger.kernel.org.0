Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D00C47E9A5
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Dec 2021 00:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240938AbhLWXQM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 18:16:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35397 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232017AbhLWXQM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 18:16:12 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BNNG6rp019370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 18:16:07 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7708215C00C8; Thu, 23 Dec 2021 18:16:06 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH v2 0/4] ext4 fast commit API cleanup
Date:   Thu, 23 Dec 2021 18:16:04 -0500
Message-Id: <164030135456.2919164.17334725963165992121.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211223202140.2061101-1-harshads@google.com>
References: <20211223202140.2061101-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 23 Dec 2021 12:21:36 -0800, Harshad Shirwadkar wrote:
> This patch series fixes up fast commit APIs. There are NO on-disk
> format changes introduced in this series. The main contribution of the
> series is that it drops fast commit specific transaction APIs and
> makes fast commits work with journal transaction APIs of JBD2
> journalling system. With these changes, a fast commit eligible
> transaction is simply enclosed in calls to "jbd2_journal_start()" and
> "jbd2_journal_stop()". If the update that is being performed is fast
> commit ineligible, one must simply call ext4_fc_mark_ineligible()
> after starting a transaction using "jbd2_journal_start()". The last
> patch in the series simplifies fast commit stats recording by moving
> it to a different function.
> 
> [...]

Applied, thanks!

[1/4] ext4: use ext4_journal_start/stop for fast commit transactions
      commit: 2729cfdcfa1cc49bef5a90d046fa4a187fdfcc69
[2/4] ext4: drop ineligible txn start stop APIs
      commit: 7bbbe241ec7ce0def9f71464c878fdbd2b0dcf37
[3/4] ext4: simplify updating of fast commit stats
      commit: 0915e464cb274648e1ef1663e1356e53ff400983
[4/4] ext4: update fast commit TODOs
      commit: d1199b94474ac4513b8491a4b751a8a466e1886b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
