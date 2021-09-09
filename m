Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D124059C3
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Sep 2021 16:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236478AbhIIO4l (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Sep 2021 10:56:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60892 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236469AbhIIO4k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Sep 2021 10:56:40 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 189EtSVY030513
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Sep 2021 10:55:28 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E778415C33EC; Thu,  9 Sep 2021 10:55:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Whitney <enwlinux@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/2] ext4: fix inline data / extent status truncation bug
Date:   Thu,  9 Sep 2021 10:55:21 -0400
Message-Id: <163119924594.1572869.14850032196390151608.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210819144927.25163-1-enwlinux@gmail.com>
References: <20210819144927.25163-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 19 Aug 2021 10:49:25 -0400, Eric Whitney wrote:
> If ext4 converts an inline file to extents when applying writes under
> delayed allocation that exceed the available inline storage, one or
> more delayed allocated extents may be stored in the extent status cache
> with an accompanying increase in the reserved block count.  If the file
> is subsequently truncated before writeback occurs, that inode's delayed
> allocated extents will not be removed from the extent status cache and
> the reserved block count will not be reduced as required after
> truncation. At minimum, unexpected ENOSPC conditions can occur.
> 
> [...]

Applied, thanks!

[1/2] ext4: remove extent cache entries when truncating inline data
      commit: 0add491df4e5e2c8cc6eeeaa6dbcca50f932090c
[2/2] ext4: enforce buffer head state assertion in ext4_da_map_blocks
      commit: 948ca5f30e1df0c11eb5b0f410b9ceb97fa77ad9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
