Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB01496CA
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 18:09:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgAYRJT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 12:09:19 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49927 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbgAYRJT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 12:09:19 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00PH8d9t012751
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 12:08:42 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 193AD420324; Sat, 25 Jan 2020 12:08:39 -0500 (EST)
Date:   Sat, 25 Jan 2020 12:08:39 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jan Kara <jack@suse.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH] Documentation: changes.rst: update several outdated
 project URLs
Message-ID: <20200125170839.GM1108497@mit.edu>
References: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
 <20200125034622.GA1107489@mit.edu>
 <c91c1ae1-7eb6-e6fd-57e3-aa8e8f356d45@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c91c1ae1-7eb6-e6fd-57e3-aa8e8f356d45@infradead.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jan 24, 2020 at 08:03:03PM -0800, Randy Dunlap wrote:
> 
> So drop the git URL also?

Let's keep the git URL; sorry I wasn't precise in my previous message.
I was referring to where the tarballs could be downloaded.

      		   	     	      - Ted

P.S. I guess I should mention that there is one reason why some folks
might still want to download from sourceforge; if they want the
tarball signed by me, that's the only place you can get it.  For
$REASONS, the .gpg file on kernel.org is signed by the kernel.org
automation, and of course the git tree has tags signed for me.  But
for folks who want the tarball signed by me --- Debian and its
derivatives want that, for example --- they need to go to sourceforge.
I dunno if the RPM-based distributions still care about gpg signed
tarballs.  I'm guessing though that the people who care know where to
find it.
