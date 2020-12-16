Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7735A2DBA3D
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 05:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725796AbgLPE4O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 23:56:14 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37701 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725789AbgLPE4O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 23:56:14 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG4tQ2x024580
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:55:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8377A420280; Tue, 15 Dec 2020 23:55:26 -0500 (EST)
Date:   Tue, 15 Dec 2020 23:55:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] jbd2: add a helper to find out number of fast commit
 blocks
Message-ID: <X9mTPjBSoULRXzp0@mit.edu>
References: <20201120202232.2240293-1-harshadshirwadkar@gmail.com>
 <20201120202232.2240293-2-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201120202232.2240293-2-harshadshirwadkar@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Nov 20, 2020 at 12:22:32PM -0800, Harshad Shirwadkar wrote:
> Add a helper to read number of fast commit blocks from jbd2 superblock
> and also rename the JBD2_MIN_FC_BLKS to
> JBD2_DEFAULT_FAST_COMMIT_BLOCKS since this constant is just the
> default number of fast commit blocks to use in case number of fast
> commit blocks isn't set in jbd2 superblock.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Thanks, applied.

					- Ted
