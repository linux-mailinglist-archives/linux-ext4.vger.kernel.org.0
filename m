Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3223EC348
	for <lists+linux-ext4@lfdr.de>; Sat, 14 Aug 2021 16:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhHNOZO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 Aug 2021 10:25:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54089 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238612AbhHNOZG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 Aug 2021 10:25:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17EEOVAO020679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Aug 2021 10:24:32 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C609715C37C1; Sat, 14 Aug 2021 10:24:31 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Boyang Xue <bxue@redhat.com>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix tune2fs checksum failure for mounted filesystem
Date:   Sat, 14 Aug 2021 10:24:29 -0400
Message-Id: <162895105421.460437.8931255765382647790.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210812124737.21981-1-jack@suse.cz>
References: <20210812124737.21981-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 12 Aug 2021 14:47:37 +0200, Jan Kara wrote:
> Commit 81414b4dd48 ("ext4: remove redundant sb checksum recomputation")
> removed checksum recalculation after updating superblock free space /
> inode counters in ext4_fill_super() based on the fact that we will
> recalculate the checksum on superblock writeout. That is correct
> assumption but until the writeout happens (which can take a long time)
> the checksum is incorrect in the buffer cache and if tune2fs is called
> in that time window it will complain. So return back the checksum
> recalculation and add a comment explaining the tune2fs peculiarity.
> 
> [...]

Applied, thanks!

[1/1] ext4: Fix tune2fs checksum failure for mounted filesystem
      commit: e905fbe3fd0fdb90052f6efdf88f50a78833cfe7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
