Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47B1319422D
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Mar 2020 15:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCZO6B (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Mar 2020 10:58:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60130 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726318AbgCZO6B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Mar 2020 10:58:01 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02QEvvIt002679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Mar 2020 10:57:58 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 62F7B420EBA; Thu, 26 Mar 2020 10:57:57 -0400 (EDT)
Date:   Thu, 26 Mar 2020 10:57:57 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: disable dioread_nolock whenever delayed allocation
 is disabled
Message-ID: <20200326145757.GT53396@mit.edu>
References: <20200319150028.24592-1-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319150028.24592-1-enwlinux@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Mar 19, 2020 at 11:00:28AM -0400, Eric Whitney wrote:
> The patch "ext4: make dioread_nolock the default" (244adf6426ee) causes
> generic/422 to fail when run in kvm-xfstests' ext3conv test case.  This
> applies both the dioread_nolock and nodelalloc mount options, a
> combination not previously tested by kvm-xfstests.  The failure occurs
> because the dioread_nolock code path splits a previously fallocated
> multiblock extent into a series of single block extents when overwriting
> a portion of that extent.  That causes allocation of an extent tree leaf
> node and a reshuffling of extents.  Once writeback is completed, the
> individual extents are recombined into a single extent, the extent is
> moved again, and the leaf node is deleted.  The difference in block
> utilization before and after writeback due to the leaf node triggers the
> failure.
> 
> The original reason for this behavior was to avoid ENOSPC when handling
> I/O completions during writeback in the dioread_nolock code paths when
> delayed allocation is disabled.  It may no longer be necessary, because
> code was added in the past to reserve extra space to solve this problem
> when delayed allocation is enabled, and this code may also apply when
> delayed allocation is disabled.  Until this can be verified, don't use
> the dioread_nolock code paths if delayed allocation is disabled.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Applied, thanks.

						- Ted
