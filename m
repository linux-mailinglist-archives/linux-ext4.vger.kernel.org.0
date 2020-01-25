Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD1C149321
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 04:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgAYDrK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jan 2020 22:47:10 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39172 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725955AbgAYDrK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jan 2020 22:47:10 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P3kN5M015593
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 22:46:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 93AA742014A; Fri, 24 Jan 2020 22:46:22 -0500 (EST)
Date:   Fri, 24 Jan 2020 22:46:22 -0500
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
Message-ID: <20200125034622.GA1107489@mit.edu>
References: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 23, 2020 at 11:00:12AM -0800, Randy Dunlap wrote:
>  ---------
>  
>  - <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
> +- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
> +- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>

You might as well deleted the URL for e2fsprogs-1.29.tar.gz while
you're at it.  That version is *old*.  I do actually still upload
e2fsprogs releases to

	https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/

... but I think just listing the www.kernel.org URL is quite
sufficient.

Other than that,

Acked-by: Theodore Ts'o <tytso@mit.edu>

						- Ted
