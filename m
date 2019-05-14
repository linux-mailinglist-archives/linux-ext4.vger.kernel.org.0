Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 191501C5E5
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2019 11:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfENJVF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 May 2019 05:21:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41976 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbfENJVE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 14 May 2019 05:21:04 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4E98a6Y012210
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2019 05:21:04 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2sftsk8fx2-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 14 May 2019 05:21:03 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <heiko.carstens@de.ibm.com>;
        Tue, 14 May 2019 10:21:01 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 May 2019 10:20:57 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x4E9KuoB51052608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 May 2019 09:20:56 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94131A4051;
        Tue, 14 May 2019 09:20:56 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 441F5A4053;
        Tue, 14 May 2019 09:20:56 +0000 (GMT)
Received: from osiris (unknown [9.152.212.21])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 14 May 2019 09:20:56 +0000 (GMT)
Date:   Tue, 14 May 2019 11:20:54 +0200
From:   Heiko Carstens <heiko.carstens@de.ibm.com>
To:     Jan Stancek <jstancek@redhat.com>, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        lkft-triage@lists.linaro.org, ltp@lists.linux.it,
        LKML <linux-kernel@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Arthur Marsh <arthur.marsh@internode.on.net>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: [LTP] LTP: Syscalls: 274 failures: EROFS(30): Read-only file
 system
References: <CA+G9fYuLXPnCmpnnLqBf5qinV6wrFx=HBH2KrB8s1HmCxLM=Zw@mail.gmail.com>
 <1723398651.22256606.1557731771283.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1723398651.22256606.1557731771283.JavaMail.zimbra@redhat.com>
X-TM-AS-GCONF: 00
x-cbid: 19051409-0012-0000-0000-0000031B773C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19051409-0013-0000-0000-000021540E58
Message-Id: <20190514092054.GA6949@osiris>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-14_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905140067
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 13, 2019 at 03:16:11AM -0400, Jan Stancek wrote:
> ----- Original Message -----
> > We have noticed 274 syscall test failures on x86_64 and i386 due to
> > Make the temporary directory in one shot using mkdtemp failed.
> > tst_tmpdir.c:264: BROK: tst_tmpdir:
> > mkdtemp(/scratch/ltp-7D8vAcYeFG/OXuquJ) failed: EROFS
> 
> Looks like ext4 bug:
> 
> [ 1916.032087] EXT4-fs error (device sda): ext4_find_extent:909: inode #8: comm jbd2/sda-8: pblk 121667583 bad header/extent: invalid extent entries - magic f30a, entries 8, max 340(340), depth 0(0)
> [ 1916.073840] jbd2_journal_bmap: journal block not found at offset 4455 on sda-8
> [ 1916.081071] Aborting journal on device sda-8.
> [ 1916.348652] EXT4-fs error (device sda): ext4_journal_check_start:61: Detected aborted journal
> [ 1916.357222] EXT4-fs (sda): Remounting filesystem read-only
> 
> So best place for report is likely linux-ext4@vger.kernel.org

Actually adding the mailing list, since there has been at least one
other report about ext4 filesystem corruption.

FWIW, I've seen the above also at least once on s390 when using a
kernel built with git commit 47782361aca2.

> > 
> > Failed log:
> > ------------
> > pread01     1  TBROK  :  tst_tmpdir.c:264: tst_tmpdir:
> > mkdtemp(/scratch/ltp-7D8vAcYeFG/preAUvXAE) failed: errno=EROFS(30):
> > Read-only file system
> > pread01     2  TBROK  :  tst_tmpdir.c:264: Remaining cases broken
> > 
> > full test log,
> > --------------
> > https://lkft.validation.linaro.org/scheduler/job/711826#L7834
> > 
> > LTP Version: 20190115
> > 
> > Kernel bad commit:
> > ------------
> > git branch master
> > git commit dd5001e21a991b731d659857cd07acc7a13e6789
> > git describe v5.1-3486-gdd5001e21a99
> > git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 
> > Kernel good commit:
> > ------------
> > git branch master
> > git commit d3511f53bb2475f2a4e8460bee5a1ae6dea2a433
> > git describe v5.1-3385-gd3511f53bb24
> > git repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > 
> > Best regards
> > Naresh Kamboju
> > 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

