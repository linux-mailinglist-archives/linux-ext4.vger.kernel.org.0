Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1AD3997CF
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Jun 2021 03:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbhFCCBG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Jun 2021 22:01:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44638 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229541AbhFCCBF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Jun 2021 22:01:05 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1531xJ3p015418
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Jun 2021 21:59:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2322815C3CAF; Wed,  2 Jun 2021 21:59:19 -0400 (EDT)
Date:   Wed, 2 Jun 2021 21:59:19 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: fix fast commit alignment issues
Message-ID: <YLg3d/BxDgTaCPEm@mit.edu>
References: <20210519215920.2037527-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519215920.2037527-1-harshads@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 19, 2021 at 02:59:20PM -0700, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> Fast commit recovery data on disk may not be aligned. So, when the
> recovery code reads it, this patch makes sure that fast commit info
> found on-disk is first memcpy-ed into an aligned variable before
> accessing it. As a consequence of it, we also remove some macros that
> could resulted in unaligned accesses.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Applied, thanks.

					- Ted
