Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2B43189E8
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 12:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhBKLyC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 06:54:02 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:46592 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhBKLvC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 06:51:02 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BBo0dR048645;
        Thu, 11 Feb 2021 11:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YsI/Zeh9f/xay3JsrvRyaQYhQnGdspV5AyS2kpao2Dw=;
 b=HU6OKgWsLE0C8LZ9EAAaPN0fv9C57nymhjHwExHIWsb/xOTWShzx7QXURcGFzLyMPGmP
 HOrhmIIgdeQqIx0dSZtVfXkc5F0jN75Sg+ARqGuSEv0Nb0Z6A0pGcZixRfEHu6yqs8sd
 wCDO8Tzx7ylO5OfqQJzpnZ9G9yN5ZZJ6XIXS8GuLcKqfg/EU6iO6mIeG6F0Ixlsoqovg
 lAvZekdqn3gKUkaIkHLKtlw8FA35bIvR/MBNRw25JZa25R/fKyGD/jePG2PjJDUDQbru
 auw8v7vgwCM+pDxGVLBN5+xyVUZ5fdjyFTzM4jv0wOnyM1ckOrSkNY7KbbBGc27og2Sk 4w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 36hgmaq8jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 11:50:00 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BBimrZ125762;
        Thu, 11 Feb 2021 11:49:55 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 36j4vu55x1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 11:49:55 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 11BBnqfo014708;
        Thu, 11 Feb 2021 11:49:52 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Feb 2021 03:49:51 -0800
Date:   Thu, 11 Feb 2021 14:49:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Jan Kara <jack@suse.cz>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a7ab8df042baaf42ae3c@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Tahsin Erdogan <tahsin@google.com>, tytso@mit.edu
Subject: Re: possible deadlock in fs_reclaim_acquire (2)
Message-ID: <20210211114943.GH2696@kadam>
References: <00000000000086723c05bb056425@google.com>
 <20210211040729.12804-1-hdanton@sina.com>
 <20210211102225.GK19070@quack2.suse.cz>
 <YCUL/icHBWeEV1Ex@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCUL/icHBWeEV1Ex@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110107
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110108
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Feb 11, 2021 at 11:50:38AM +0100, 'Michal Hocko' via syzkaller-bugs wrote:
> On Thu 11-02-21 11:22:25, Jan Kara wrote:
> > On Thu 11-02-21 12:07:29, Hillf Danton wrote:
> 
> I haven't received Hillf's email.
> 
> [...]
> > > Fix 71b565ceff37 ("ext4: drop ext4_kvmalloc()") by restoring the
> > > GFP_NOFS introduced in dec214d00e0d ("ext4: xattr inode deduplication").
> > > 
> > > Note this may be the fix also to possible deadlock
> > >  Reported-by: syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com
> > >  https://lore.kernel.org/linux-ext4/000000000000563a0205bafb7970@google.com/
> > 
> > Please no. Ext4 is using scoping API to limit allocations to GFP_NOFS
> > inside transactions. In this case something didn't work which seems like a
> > lockdep bug at the first sight but I'll talk to mm guys about it.
> > Definitely to problem doesn't seem to be in ext4.
> 
> Agreed. kvmalloc(NOFS) is not even supported because vmalloc doesn't
> support GFP_KERNEL incompatible requests.

Okay.  I have created a new Smatch warning when people pass GFP_NOFS
to kvmalloc() and friends.  We'll see if it finds anything tomorrow.

(We could probably find the same information with grep, but I run
Smatch every day so it prevents future bugs).

regards,
dan carpenter

