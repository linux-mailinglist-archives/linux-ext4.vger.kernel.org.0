Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E13451AC7B3
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Apr 2020 16:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394840AbgDPO6Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Apr 2020 10:58:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393000AbgDPO6W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Apr 2020 10:58:22 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GEq5oJ193726
        for <linux-ext4@vger.kernel.org>; Thu, 16 Apr 2020 10:58:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30esgbg5yj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 16 Apr 2020 10:58:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 16 Apr 2020 15:57:50 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 16 Apr 2020 15:57:47 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03GEwEJx56754356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Apr 2020 14:58:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFA84A405B;
        Thu, 16 Apr 2020 14:58:14 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2FA6A4054;
        Thu, 16 Apr 2020 14:58:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.92.159])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Apr 2020 14:58:11 +0000 (GMT)
Subject: Re: WARNING in iomap_apply
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
References: <0000000000007beadf05a36790eb@google.com>
Cc:     syzbot <syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-unionfs@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 16 Apr 2020 20:28:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0000000000007beadf05a36790eb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20041614-0008-0000-0000-00000371CF2E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041614-0009-0000-0000-00004A93877B
Message-Id: <20200416145811.A2FA6A4054@b06wcsmtp001.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_05:2020-04-14,2020-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004160101
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ok, so here is the syzbot report and the patch with which it was
tested is mentioned below.
Previous patch had some formatting issue and a semicolon missing:
(mistakenly sent out a non-tested version of the patch).

So will be sending out this tested version this time.
Sorry about the spam.

-ritesh

On 4/16/20 5:58 PM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch and the reproducer did not trigger crash:
> 
> Reported-and-tested-by: syzbot+77fa5bdb65cc39711820@syzkaller.appspotmail.com
> 
> Tested on:
> 
> commit:         7e634208 Merge tag 'acpi-5.7-rc1-2' of git://git.kernel.or..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> kernel config:  https://syzkaller.appspot.com/x/.config?x=12205d036cec317f
> dashboard link: https://syzkaller.appspot.com/bug?extid=77fa5bdb65cc39711820
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=10478f77e00000
> 
> Note: testing is done by a robot and is best-effort only.
> 

