Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E106616576C
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 07:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBTGOg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 01:14:36 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57374 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725942AbgBTGOf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Feb 2020 01:14:35 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01K6ESui008025
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Feb 2020 01:14:30 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5C1E34211EF; Thu, 20 Feb 2020 01:14:28 -0500 (EST)
Date:   Thu, 20 Feb 2020 01:14:28 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Suraj Jitindar Singh <surajjs@amazon.com>
Cc:     linux-ext4@vger.kernel.org, sblbir@amazon.com,
        sjitindarsingh@gmail.com
Subject: Re: [PATCH 0/3] ext4: Fix potential races when performing online
 resizing
Message-ID: <20200220061428.GG476845@mit.edu>
References: <20200219030851.2678-1-surajjs@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219030851.2678-1-surajjs@amazon.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Suraj,

All of the patches to fix BZ 206443 are now on the ext4 git tree:

https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/log/?h=dev

I'm currently giving them a full regression test set using xfstests.
Could you run your tests to make sure it looks good for you?

I'm hoping to issue a pull request to Linus in time for 5.6-rc3 by
this weekend.

Also, if you can figure out a way to package up the repro as an
xfstests test case, that would be really excellent.  I think the
challenge is that some of them took a *huge* amount of pounding before
they repro'ed, correct?  I wasn't actually able to trigger the repro
using kvm, but I was only using a 2 CPU configuration.

Thanks,

						- Ted

