Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9000A1748A1
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Feb 2020 19:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbgB2SRY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 29 Feb 2020 13:17:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47844 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727177AbgB2SRY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 29 Feb 2020 13:17:24 -0500
Received: from callcc.thunk.org (75-104-88-164.mobility.exede.net [75.104.88.164] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01TIHCjh021980
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 29 Feb 2020 13:17:19 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8439D42045B; Sat, 29 Feb 2020 13:17:11 -0500 (EST)
Date:   Sat, 29 Feb 2020 13:17:11 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: ENOSPC inline_data fsck failure
Message-ID: <20200229181711.GD7378@mit.edu>
References: <20200228105234.n5wt5x2vi3ftxuyh@xzhoux.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228105234.n5wt5x2vi3ftxuyh@xzhoux.usersys.redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 28, 2020 at 06:52:34PM +0800, Murphy Zhou wrote:
> 
> With inline_data mkfs option, generic/083 can easily trigger
> a fsck failure like this:
> 
> The testcase is doing a simple testing: make a small(256M) fs,
> run fsstress in it,  make it out of space. Then fsck.
> 
> Not sure about is this an issue of ext4 filesystem or e2fsck
> needs more options.

This is an ext4 bug.  It's been on my radar screen to investigate one
of these days, but I've just never gotten around to it.  I'm guessing
the bug is the error handling case when an inline directory is getting
converted directory where its contents are stored in data blocks, and
the block allocation fails due to the ENOSPC.

						- Ted
