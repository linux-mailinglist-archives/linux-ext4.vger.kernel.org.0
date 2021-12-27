Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B536D47FA59
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Dec 2021 06:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhL0Fey (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Dec 2021 00:34:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35668 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232405AbhL0Fex (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Dec 2021 00:34:53 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BR5YjnK027871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 00:34:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7413D15C33A3; Mon, 27 Dec 2021 00:34:45 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, brookxu <brookxu.cn@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH v3] ext4: fix a possible ABBA deadlock dued to busy PA
Date:   Mon, 27 Dec 2021 00:34:39 -0500
Message-Id: <164058326343.3172825.1428893556687431566.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1637630277-23496-1-git-send-email-brookxu.cn@gmail.com>
References: <1637630277-23496-1-git-send-email-brookxu.cn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 23 Nov 2021 09:17:57 +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> We found on older kernel (3.10) that in the scenario of insufficient
> disk space, system may trigger an ABBA deadlock problem, it seems that
> this problem still exists in latest kernel, try to fix it here. The
> main process triggered by this problem is that task A occupies the PA
> and waits for the jbd2 transaction finish, the jbd2 transaction waits
> for the completion of task B's IO (plug_list), but task B waits for
> the release of PA by task A to finish discard, which indirectly forms
> an ABBA deadlock. The related calltrace is as follows:
> 
> [...]

Applied, thanks!

[1/1] ext4: fix a possible ABBA deadlock dued to busy PA
      commit: 1754b684bf05c9c00b40e745a57f9ca9696ad9c1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
