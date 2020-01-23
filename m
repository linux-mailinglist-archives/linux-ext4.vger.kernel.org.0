Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B563147512
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jan 2020 00:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgAWXyN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 18:54:13 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45440 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729277AbgAWXyM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jan 2020 18:54:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bgKW+J/FqGAQgoMhgI1N/oYW+JVXIpMbXjqOj6SbCQo=; b=SHKwoRWceYdc+xm+r4rtx8R1A
        HzkrMHl7ciXXgFIuNZRQ3tPE2mdCKYCp6K9K0Aw4sZj75SrRP78z6Oax18ZJyJW2ogBU6jBmjv6Js
        3YIJg6duKUB0Ij18nhcG5PFoVZhR8cUDTKWbdwU16f/sFi+JBUALjx5rTawnLev+jwOxoRaXtXJWz
        AnpE4oZRuz9jQJMxMH/Ub87EWOic/S6rrG3NGLg1KvlhfrkpZ5g+A984+tL1BRILoZYzL80Po/Ycx
        vkWVXyilpu8gx7H79Om8Ta+cC/kpy7KngJJWhuqHdaQMzDQYgTMZh++78fGa0ZREqKNNKkRSImc2o
        jXFTHgOMA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iumIc-0003Cp-VM; Thu, 23 Jan 2020 23:54:11 +0000
Subject: Re: [PATCH] Documentation: changes.rst: update several outdated
 project URLs
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Jan Kara <jack@suse.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        Paul Mackerras <paulus@samba.org>, linux-ppp@vger.kernel.org,
        reiserfs-devel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>
References: <efb1f518-9e66-c472-d124-4b7d91e56639@infradead.org>
 <20200123195531.GW8247@magnolia>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <792339b0-5fa1-4347-11e2-2620f498856c@infradead.org>
Date:   Thu, 23 Jan 2020 15:54:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200123195531.GW8247@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 1/23/20 11:55 AM, Darrick J. Wong wrote:
> On Thu, Jan 23, 2020 at 11:00:12AM -0800, Randy Dunlap wrote:
>> From: Randy Dunlap <rdunlap@infradead.org>
>>
>> Update projects URLs in the changes.rst file.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Cc: Jan Kara <jack@suse.com>
>> Cc: "Theodore Ts'o" <tytso@mit.edu>
>> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
>> Cc: linux-ext4@vger.kernel.org
>> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
>> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
>> Cc: Florian Westphal <fw@strlen.de>
>> Cc: netfilter-devel@vger.kernel.org
>> Cc: coreteam@netfilter.org
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: linux-ppp@vger.kernel.org
>> Cc: Jan Kara <jack@suse.com>
>> Cc: reiserfs-devel@vger.kernel.org
>> Cc: Darrick J. Wong <darrick.wong@oracle.com>
>> Cc: linux-xfs@vger.kernel.org
>> ---
>>
>>  Documentation/process/changes.rst                    |   12 ++++++----
>>  Documentation/translations/it_IT/process/changes.rst |   12 ++++++----
>>  2 files changed, 16 insertions(+), 8 deletions(-)
>>
>> diff -Naurp linux-next-20200123/Documentation/translations/it_IT/process/changes.rst%WWW linux-next-20200123/Documentation/translations/it_IT/process/changes.rst
>> --- linux-next-20200123/Documentation/translations/it_IT/process/changes.rst%WWW	2019-11-24 16:32:01.000000000 -0800
>> +++ linux-next-20200123/Documentation/translations/it_IT/process/changes.rst	2020-01-23 10:47:56.226457425 -0800
>> @@ -391,6 +391,8 @@ E2fsprogs
>>  ---------
>>  
>>  - <http://prdownloads.sourceforge.net/e2fsprogs/e2fsprogs-1.29.tar.gz>
>> +- <https://www.kernel.org/pub/linux/kernel/people/tytso/e2fsprogs/>
>> +- <https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/>
>>  
>>  JFSutils
>>  --------
>> @@ -400,12 +402,12 @@ JFSutils
>>  Reiserfsprogs
>>  -------------
>>  
>> -- <http://www.kernel.org/pub/linux/utils/fs/reiserfs/>
>> +- <https://git.kernel.org/pub/scm/linux/kernel/git/jeffm/reiserfsprogs.git/>
>>  
>>  Xfsprogs
>>  --------
>>  
>> -- <ftp://oss.sgi.com/projects/xfs/>
>> +- <https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git>
> 
> Can we add a link to the release tarballs too?
> 
> https://www.kernel.org/pub/linux/utils/fs/xfs/xfsprogs/
> 
> With that amended,
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> --D

Sure, I added that link.
I'll wait a bit for other comments before posting v2.

thanks.
-- 
~Randy

