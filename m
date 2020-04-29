Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46B11BE1E6
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgD2PBr (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Apr 2020 11:01:47 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45592 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgD2PBr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Apr 2020 11:01:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TEwpEr041213;
        Wed, 29 Apr 2020 15:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=mLQm8W1JZ8Wsk52oDobZsmTJ+VkLl+LopP88fPaeu70=;
 b=X0HlqtLpxP2ipQBGMJ0vUxUCCfjiQXkaDFqzbmGZP+3UgfywZWYhQYNJ21AZv7DtUQvI
 05Ryd+ClzwiDbdPEWhXbOCB4oP0rZZ8k8vnAFOaQVV/kwr/PENoQp0yKE1b2v83Id0Ji
 a0oaBoUPBqR9VmmNqpe85LMKA0YhA6n1LCyI+UpZgGEB0w0sz1ItUTwyfgHHuoKXwoEy
 67z+mjuBAQrifsZp6/I+V6kR5yXJaaFdKMkq0o8GItpNd9D+jICQOmsxQibaHvTUXdka
 FW48LdsY7oQsYeY4xyB8szAtxLQF/9u6oF9yhzXmzwvj9UvMn2es8mrvWoN2fmalJTV8 /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 30nucg69pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 15:01:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03TEvxWb044728;
        Wed, 29 Apr 2020 15:01:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 30pvd17pdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Apr 2020 15:01:37 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03TF1Y79011090;
        Wed, 29 Apr 2020 15:01:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 Apr 2020 08:01:33 -0700
Date:   Wed, 29 Apr 2020 08:01:32 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Jan Kara <jack@suse.cz>, Francois <rigault.francois@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext4 and project quotas bugs
Message-ID: <20200429150132.GJ6733@magnolia>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
 <20200428153228.GB6426@quack2.suse.cz>
 <3FF8B32A-0CB2-4818-95AA-5E76FE494EDB@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF8B32A-0CB2-4818-95AA-5E76FE494EDB@dilger.ca>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9606 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 mlxlogscore=999 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004290125
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 09:34:09PM -0600, Andreas Dilger wrote:
> On Apr 28, 2020, at 9:32 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > Hello!
> > 
> > On Tue 28-04-20 08:41:59, Francois wrote:
> >> my goal is to make some kind of ansible playbook to install project
> >> quotas, so I am interested in using a tool like setquota, I also want
> >> the teams behind the capped directories, to think about a clean-up
> >> mechanism (the quota would just be a temporary annoyance for them), so
> >> it should not be "jailbreakable" too easily.
> > 
> > Hum, that "not jailbreakable" part is going to be difficult unless you also
> > confine those users also in their user namespace. Because any user is
> > allowed to change project ID of the files he owns arbitrarily if he is
> > running in the initial user namespace. Project quotas have been designed as
> > an advisory feature back in Irix days... There are talks of allowing to
> > tweak the behavior (i.e., to allow setting of project id only by sysadmin)
> > by a mount option but so far nobody has implemented it.
> 
> We tried to implement this for ext4, but Dave Chinner argued that
> allowing anyone (at least in the root namespace) to set the project
> ID to anything they wanted was part of how project quotas are
> _supposed_ to work.
> 
> We ended up adding a restriction at the Lustre level, defaulting to
> only allow root (chprojid_gid=0, via CAP_SYS_RESOURCE), or admins in
> a specific numeric group (with chprojid_gid=N), to change the projid,
> and denying regular users the ability to change the projid of files.
> 
> This can be changed by setting "chprojid_gid=-1" to allow users in
> any group to change the projid of files, returning the XFS behavior.
> The "chprojid_gid" is essentially a sysfs tunable for Lustre, but it
> could also/instead be a mount option for ext4, if that is preferred.
> I don't have a particular attachment to the parameter name, or how
> it is set by the admin, but I think something like this is needed.
> 
> 
> >> 2- project quota are a bit too easy to escape:
> >> dd if=/dev/zero of=someoutput oflag=append
> >> loop0: write failed, project block limit reached.
> >> dd: writing to 'someoutput': Disk quota exceeded
> >> 2467+0 records in
> >> 2466+0 records out
> >> 1262592 bytes (1.3 MB, 1.2 MiB) copied, 0.0105432 s, 120 MB/s
> >> vagrant@localhost:/mnt/loop/abc/mydir3> chattr -p 33 someoutput
> >> vagrant@localhost:/mnt/loop/abc/mydir3> dd if=/dev/zero of=someoutput
> >> oflag=append
> >> dd: writing to 'someoutput': No space left on device
> >> 127393+0 records in
> >> 127392+0 records out
> >> 65224704 bytes (65 MB, 62 MiB) copied, 0.568859 s, 115 MB/s
> > 
> > Yes and as I mentioned above this is deliberate.
> 
> That may be the historical XFS behavior, but IMHO, it doesn't make
> this behavior *useful*.  If *anyone* can change the projid of files
> that makes them mostly useless.  They might be OK for informational
> or accounting purposes (e.g. fast "du" of a directory) in a friendly
> user environment, but they are useless for any space management (i.e.
> anyone can easily bypass project limits by "chattr -p $RANDOM <file>").
> 
> I'd prefer to make the project quotas useful out of the box for ext4,
> by implementing the chprojid_gid tunable, or something equivalent.
> If there are users/sites that want identical behavior to XFS, they
> can always set chprojid_gid=-1 to allow anyone to change the projid.
> 
> I'd be happy to understand what Dave doesn't like about this proposal,
> but the last time the enforcement of project quotas was discussed, my
> attempt to figure this out ended with silence, see thread ending at:
> 
> https://lore.kernel.org/linux-ext4/6B0D1F84-0718-4E43-87D4-C8AFC94C0163@dilger.ca/
> 
> Maybe this time we can get over the hump?  Is it just some implicit
> difference between "directory quota" and "project quota" that exists
> in XFS that I (and everyone using ext4) does not understand?

I don't have any particular objection to adding an admin-controlled
means to restrict who can change project ids on a file, other than let's
do this in a consistent way for the three fses that support prjquota.

Personally, I thought Dave was stating how we got to the current
prjquota implementation w/ non-entirely-intuitive Irix behavior and then
asked for a concrete definition of new behavior + patches and was
waiting to see if Wang or someone would send out f2fs/ext4/xfs patches...

--D

> Cheers, Andreas
> 
> 
> PS: Implementing /etc/projid support for e2fsprogs chattr/lsattr to
> allow project names would also be useful, but IMHO less important.
> That would be a relatively easy feature for someone to implement,
> since it only involves userspace and is unlikely to get objections.
> 
> 
> 


