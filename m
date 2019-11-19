Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0E9101267
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Nov 2019 05:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfKSEVh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Nov 2019 23:21:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59373 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727018AbfKSEVh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Nov 2019 23:21:37 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-103.corp.google.com [104.133.8.103] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAJ4LKH0021003
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Nov 2019 23:21:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 221784202FD; Mon, 18 Nov 2019 23:21:20 -0500 (EST)
Date:   Mon, 18 Nov 2019 23:21:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        syzbot+f8d6f8386ceacdbfff57@syzkaller.appspotmail.com,
        stable@kernel.org
Subject: Re: [PATCH -v2] ext4: add more paranoia checking in
 ext4_expand_extra_isize handling
Message-ID: <20191119042120.GD4262@mit.edu>
References: <20191108024841.9668-1-tytso@mit.edu>
 <201911101835.qg5bu1Me%lkp@intel.com>
 <20191110121510.GH23325@mit.edu>
 <20191119021526.GB3147@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119021526.GB3147@sol.localdomain>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 18, 2019 at 06:15:26PM -0800, Eric Biggers wrote:
> Is this patch intended to address
> https://lore.kernel.org/linux-ext4/000000000000950f21059564e4c7@google.com
> as well?  If so, you can add the second Reported-by line so that both syzbot
> reports get closed.

Yes, it appears to be the same issue.  Thanks for pointing this out!

     		      	       	       - Ted
