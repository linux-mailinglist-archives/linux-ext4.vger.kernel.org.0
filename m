Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 027801A8AC
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2019 19:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbfEKRUG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 11 May 2019 13:20:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47283 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726272AbfEKRUG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 11 May 2019 13:20:06 -0400
Received: from callcc.thunk.org (rrcs-67-53-55-100.west.biz.rr.com [67.53.55.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4BHJaar030275
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 11 May 2019 13:19:38 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EC26842002C; Fri, 10 May 2019 21:53:04 -0400 (EDT)
Date:   Fri, 10 May 2019 21:53:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix data corruption caused by overlapping
 unaligned and aligned IO
Message-ID: <20190511015304.GE2534@mit.edu>
References: <20190506134952.26070-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506134952.26070-1-lczerner@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 06, 2019 at 03:49:52PM +0200, Lukas Czerner wrote:
> Unaligned AIO must be serialized because the zeroing of partial blocks
> of unaligned AIO can result in data corruption in case it's overlapping
> another in flight IO.
> 
> Currently we wait for all unwritten extents before we submit unaligned
> AIO which protects data in case of unaligned AIO is following overlapping
> IO. However if a unaligned AIO is followed by overlapping aligned AIO we
> can still end up corrupting data.
> 
> To fix this, we must make sure that the unaligned AIO is the only IO in
> flight by waiting for unwritten extents conversion not just before the
> IO submission, but right after it as well.
> 
> This problem can be reproduced by xfstest generic/538
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Many thanks, applied.

						- Ted
