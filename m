Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C874FCBCB
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Nov 2019 18:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfKNR2A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Nov 2019 12:28:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38934 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725601AbfKNR2A (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Nov 2019 12:28:00 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAEHRs2I028128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Nov 2019 12:27:55 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A58514202FD; Thu, 14 Nov 2019 12:27:54 -0500 (EST)
Date:   Thu, 14 Nov 2019 12:27:54 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jesse Grodman <jgrodman@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Suggested change for superblock journal hint
Message-ID: <20191114172754.GB4579@mit.edu>
References: <CACtp79ADncLAs560QNKCZtX937XaB6-37Xz2SYP7PyonJjRtwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACtp79ADncLAs560QNKCZtX937XaB6-37Xz2SYP7PyonJjRtwg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 14, 2019 at 05:05:06PM +0200, Jesse Grodman wrote:
> Hi,
> 
> I encountered the scenario that a full fsck check was being run
> unnecessarily when the major / minor number of my external journal was
> being fixed by fsck. This PR changes that so that this change does
> trigger the full fsck run: github.com/tytso/e2fsprogs/pull/26

Hi Jessie,

It's preferable that patches e2fsprogs be sent to the linux-ext4 list,
so they can get reviewed by the full ext4 community.  That being said,
I will accept minor patches sent via a pull request if they full meet
the requirements for kernel patches:

https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Note in particular the requirements for the Developer's Certification
of Origin (aka the Signed-off-by tag).  That has specific legal
meanings (for example, you are certifying that your employer allows
you to contribute to open source projects, or at least, *this* open
source project), so please take a close look at that.

Cheers,

					- Ted
