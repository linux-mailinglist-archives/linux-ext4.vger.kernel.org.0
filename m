Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3EE375F05
	for <lists+linux-ext4@lfdr.de>; Fri,  7 May 2021 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbhEGDMC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 May 2021 23:12:02 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53143 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229942AbhEGDMB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 May 2021 23:12:01 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1473AxgU014154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 May 2021 23:10:59 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2853715C39BD; Thu,  6 May 2021 23:10:59 -0400 (EDT)
Date:   Thu, 6 May 2021 23:10:59 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] e2fsck: fix unaligned accesses to ext4_fc_tl struct
Message-ID: <YJSvw6oy1Rg6eIrJ@mit.edu>
References: <20210507002110.3933387-1-harshads@google.com>
 <20210507002110.3933387-2-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210507002110.3933387-2-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, May 06, 2021 at 05:21:10PM -0700, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Fast commit related struct ext4_fc_tl can be unaligned on disk. So,
> while accessing that we should ensure that the pointers are
> aligned. This patch fixes unaligned accesses to ext4_fc_tl and also
> gets rid of macros fc_for_each_tl and ext4_fc_tag_val that may result
> in unaligned accesses to struct ext4_fc_tl.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Looks good.  I wrote my reply with a proposed version of
ext4_fc_tag_val() before I saw your patch.

This patch wasn't enough to fix the sparc64 crash, but after doing
some additional investigation, I was able to figure out how to fix
things so that j_recovery_fast_commit is working on sparc64.  Patch
follows on this thread...

					- Ted
