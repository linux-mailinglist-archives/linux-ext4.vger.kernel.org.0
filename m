Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2863E2DB8
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Aug 2021 17:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbhHFPYR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Aug 2021 11:24:17 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46219 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S244335AbhHFPYP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Aug 2021 11:24:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 176FNtfj004734
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Aug 2021 11:23:56 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 694E515C3E1B; Fri,  6 Aug 2021 11:23:55 -0400 (EDT)
Date:   Fri, 6 Aug 2021 11:23:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH RESEND] tests: skip u_direct_io if losetup fails
Message-ID: <YQ1UCzIQLliQ3TAU@mit.edu>
References: <20210805154328.GB3601392@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805154328.GB3601392@magnolia>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 05, 2021 at 08:43:28AM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> This new test requires a loop device to run testing.  While it checks
> for some "obvious" parameters that might cause the test to fail such as
> not being root and no losetup executable, it doesn't actually check that
> the losetup -a call succeeds.  This causes a test regression in my
> package building container (where there is only a minimal /dev with no
> loop devices available) so I can't build debian packages.
> 
> Fix the test to skip out if we can't create a loop device.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>

Applied, thanks.

					- Ted
