Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9721BC429
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Apr 2020 17:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgD1PyA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 11:54:00 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45826 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbgD1PyA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Apr 2020 11:54:00 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFrHtI117679;
        Tue, 28 Apr 2020 15:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=xtJUM7ThCCGRF1vfZ4c2Z/I/Y10yMZ8g324wsyKSQ9c=;
 b=PEIK/jUxvR7KZGG/5RsrTWjWu6UfFyJechsL77G5n/PIKQdqqc51rpwkYhthisl9gSVF
 5+zZcMR+6DFWgjJ9YvC6aKIrb2SLHVLQx78VPMAw2Um7o/kZHFtPJx5kRQQvvejxy1mp
 7u2v3MTWHSudTCRtJ65jT6YoH3yZuZUJ4esVVBJZuNsIQuCWFrwftVm/MATG6/REGaSS
 F8c4DuO342KtWyB/7B8D+1BQErPl802W5qFKRNEx/3PIx1LtVzibQ3j+2qJVzmZ+L6eq
 7e0GI/xIj2NRNiFllPbu843srOvfZb2eDVXUOyMjRokME+LmgCMhm53w4p1MjOmZ4uXb /A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30p2p0680x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:53:53 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03SFqjMj047011;
        Tue, 28 Apr 2020 15:53:53 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30mxpgaws9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 15:53:53 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03SFrqBD028488;
        Tue, 28 Apr 2020 15:53:52 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Apr 2020 08:53:52 -0700
Date:   Tue, 28 Apr 2020 08:53:51 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Francois <rigault.francois@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: ext4 and project quotas bugs
Message-ID: <20200428155351.GH6733@magnolia>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
 <20200428153228.GB6426@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428153228.GB6426@quack2.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004280124
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9605 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 clxscore=1011
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004280124
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 05:32:28PM +0200, Jan Kara wrote:
> Hello!
> 
> On Tue 28-04-20 08:41:59, Francois wrote:
> > hello! I was just giving ext4 project quotas a try. Definitely not the
> > most used ext4 feature (I was the first to answer a stackoverflow
> > question on it in https://stackoverflow.com/a/61465057/2852464).
> > Quotacheck tells me to mail you the bugs :D so I do
> 
> Sure :) Generally for ext4 issues (including project quotas) you can also
> ask at linux-ext4@vger.kernel.org (added to CC so that the discussion is
> archived for other people).
> 
> > my goal is to make some kind of ansible playbook to install project
> > quotas, so I am interested in using a tool like setquota, I also want
> > the teams behind the capped directories, to think about a clean-up
> > mechanism (the quota would just be a temporary annoyance for them), so
> > it should not be "jailbreakable" too easily.
> 
> Hum, that "not jailbreakable" part is going to be difficult unless you also
> confine those users also in their user namespace. Because any user is
> allowed to change project ID of the files he owns arbitrarily if he is
> running in the initial user namespace. Project quotas have been designed as
> an advisory feature back in Irix days... There are talks of allowing to
> tweak the behavior (i.e., to allow setting of project id only by sysadmin)
> by a mount option but so far nobody has implemented it.
> 
> > quota-4.05-3.1.x86_64
> > Linux localhost 5.6.2-1-default #1 SMP Thu Apr 2 06:31:32 UTC 2020
> > (c8170d6) x86_64 x86_64 x86_64 GNU/Linux
> > CPE_NAME="cpe:/o:opensuse:tumbleweed:20200413"
> > 
> > 1- quotacheck fails with quotacheck: Cannot find filesystem to check
> > or filesystem not mounted with quota option.
> > prjquota is enabled using extended mount options but quotacheck seems
> > to ignore this
> > # tune2fs -l /dev/loop0 | grep -i mount\ opt
> > Default mount options: user_xattr acl
> > Mount options: prjquota
> > 
> > (also, shouldn't these mount options be reflected in /proc/mounts?)
> 
> Yes and that's deliberate. Unlike user and group quotas, project quotas are
> only supported when stored in hidden system files (user and group quotas
> are also supported in that way when you create ext4 with 'quota' feature).
> So checking of quotas is handled by e2fsck and quotacheck has no way to
> influence them.

How /does/ one enable whatever the latest iteration on quota is in ext4?
IIRC the old VFS method (independent non-journalled quota files in the
root dir) is deprecated, which means that the preferred method now is:

# mkfs.ext4 -O quota -E quotatype=usrquota:grpquota:prjquota /dev/fd0

right?

> > 2- project quota are a bit too easy to escape:
> > dd if=/dev/zero of=someoutput oflag=append
> > loop0: write failed, project block limit reached.
> > dd: writing to 'someoutput': Disk quota exceeded

EDQUOT?  Hrm, XFS usually returns ENOSPC for project quotas, since we
also change the statfs output to make it look like the the mount size is
the project quota's hard limit.

> > 2467+0 records in
> > 2466+0 records out
> > 1262592 bytes (1.3 MB, 1.2 MiB) copied, 0.0105432 s, 120 MB/s
> > vagrant@localhost:/mnt/loop/abc/mydir3> chattr -p 33 someoutput
> > vagrant@localhost:/mnt/loop/abc/mydir3> dd if=/dev/zero of=someoutput
> > oflag=append
> > dd: writing to 'someoutput': No space left on device
> > 127393+0 records in
> > 127392+0 records out
> > 65224704 bytes (65 MB, 62 MiB) copied, 0.568859 s, 115 MB/s
> 
> Yes and as I mentioned above this is deliberate.
> 
> > 3- project id '-1" yields fun results:
> > 
> > chattr +P -p -1 .

Heh, that command doesn't work on xfs.  Weird, more kernel bugs to chase...

> > dd if=/dev/zero of=someoutput oflag=append
> > dd: failed to open 'someoutput': Invalid argument
> 
> Yes, that's a bug that should be fixed. Thanks for reporting this! -1 means
> 'this id is not expressible in current user namespace' and some code gets
> confused along the way. We should refuse to set project -1 for a file...

Awkward part: projid 4294967295 is allowed on XFS (at least by the
kernel), though the xfs quota tools do not permit that.

--D

> > 4- setquota fails but return code is zero
> > > /usr/sbin/setquota -P 1 2 3 4 5 /dev/loop0 && echo success!
> > setquota: Cannot get quota for project 1 from kernel on /dev/loop0:
> > Operation not permitted
> > setquota: error while getting quota from /dev/loop0 for #1 (id 1):
> > Operation not permitted
> > success!
> 
> OK, so you are unpriviledged user here, aren't you? So the failure is
> expected, just the return code is wrong. Do I understand your complaint
> correctly? I'm not able to reproduce that error:
> 
> nobody@kvm0:/root> /root/source/quota-tools/setquota -P 1 2 3 4 5 /dev/vdb1 && echo success
> bash: /root/source/quota-tools/setquota: Permission denied
> nobody@kvm0:/root>
> 
> Or what exactly are you testing?
> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
