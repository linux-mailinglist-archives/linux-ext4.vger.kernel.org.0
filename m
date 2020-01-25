Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC4814933A
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 05:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAYEDJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jan 2020 23:03:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48446 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgAYEDJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jan 2020 23:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KP695KDNkM9ZC3AfgzwuXXwzb4XfRID8VnwqvlZke1Q=; b=Mf2/LLiggfYiPh6JEjNPhYdSo
        7rtYhmZK2ffx2c/y2co39Dy9QDirx2IZ12xN/B9nqwg35Mo07Uje+lkVrWEAam8wf0QWDEQkji3DX
        Xk/gYLmGerBWvSwIosjulKd5h8GVuiDZDaQLIrJbDo2GBLwIKNEmieG+vYh3H3TVBFLMH9BXgOF+7
        B3I2RMZYNKm/bIDKdvSGoPpVI0eEjy83gCZmko9PuSCjS44J0a+wX5Ira30LPKjICYqOnVid2kNjO
        TD0B5sTJMsmlbdpPdu8bunczdFnx+74pMotC/q1VMQI/FMwXPkD3pWEcgWoB82CEmxVbLZVDYqNy+
        8eO6jBcsQ==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ivCf2-0000dZ-Gm; Sat, 25 Jan 2020 04:03:04 +0000
Subject: Re: [PATCH] Documentation: changes.rst: update several outdated
 project URLs
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
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
References: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
 <20200125034622.GA1107489@mit.edu>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c91c1ae1-7eb6-e6fd-57e3-aa8e8f356d45@infradead.org>
Date:   Fri, 24 Jan 2020 20:03:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200125034622.GA1107489@mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 1/24/20 7:46 PM, Theodore Y. Ts'o wrote:
> On Thu, Jan 23, 2020 at 11:00:12AM -0800, Randy Dunlap wrote:
>>  ---------
>>  
>>  - <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
>> +- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
>> +- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
> 
> You might as well deleted the URL for e2fsprogs-1.29.tar.gz while
> you're at it.  That version is *old*.  I do actually still upload

OK, I did that.

> e2fsprogs releases to
> 
> 	https://sourceforge.net/projects/e2fsprogs/files/e2fsprogs/
> 
> ... but I think just listing the www.kernel.org URL is quite
> sufficient.

So drop the git URL also?

-- <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
+- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
+- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>


thanks.
-- 
~Randy

