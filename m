Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABC517B0A5
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Mar 2020 22:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgCEV2a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 16:28:30 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36242 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbgCEV2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 16:28:30 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 025LSL7K020859
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 16:28:21 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id F2A1942045B; Thu,  5 Mar 2020 16:28:20 -0500 (EST)
Date:   Thu, 5 Mar 2020 16:28:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4:  delete declaration for ext4_split_extent()
Message-ID: <20200305212820.GF20967@mit.edu>
References: <20200212162141.22381-1-enwlinux@gmail.com>
 <20200212170236.GA6863@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212170236.GA6863@magnolia>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Feb 12, 2020 at 09:02:36AM -0800, Darrick J. Wong wrote:
> On Wed, Feb 12, 2020 at 11:21:41AM -0500, Eric Whitney wrote:
> > There are no forward references for ext4_split_extent() in extents.c,
> > so delete its unnecessary declaration.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> 
> Looks good to me,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

Applied, thanks.

					- Ted
