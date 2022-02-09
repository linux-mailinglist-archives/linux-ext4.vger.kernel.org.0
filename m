Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E719B4AEA86
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 07:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233532AbiBIGnw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 01:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiBIGnu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 01:43:50 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C4BC03E900;
        Tue,  8 Feb 2022 22:43:54 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2196RJtj008756;
        Wed, 9 Feb 2022 06:43:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=pkrY0pIOU2e93AxmO7zanzB1euNrDknGvvrsBpHJO6Y=;
 b=T8dw8w7HtkntGTnxbtcLu/39GaMLA1MZD8zOczzniKYiVM1R3SpqZGm7WlVVX5X4SLsV
 5qOIHB1QsvMih+jkrIe6hmYy9Vr1tiINIXlr1Sna1yFupQDBZ75xLKv4nUrT9j1XqN3D
 aPKKiQx6nVVd/c4tajBHlEmzg/oXBtQk5S2cta06URAxhfCNV2/7+jrp1WWXB6cVOU17
 qeulsU4ytT5ae26uNIUafgz5U01PPNShXOMq9o8zkcYlWV71hFsfRCyr/LA8/NObtB06
 qs1P5Pxk5ChGJiUuAYJNuUGpO10QJkMbXAqbbw8AR/rfP91efauS6rjK2dSGDud3LQIA dQ== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e48c10eta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 06:43:44 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2196Stgs021263;
        Wed, 9 Feb 2022 06:43:42 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma04fra.de.ibm.com with ESMTP id 3e2ygq9ba3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 06:43:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2196hdsa46924138
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 06:43:39 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAEB0AE04D;
        Wed,  9 Feb 2022 06:43:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39324AE056;
        Wed,  9 Feb 2022 06:43:39 +0000 (GMT)
Received: from localhost (unknown [9.43.124.244])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  9 Feb 2022 06:43:38 +0000 (GMT)
Date:   Wed, 9 Feb 2022 12:13:38 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
Cc:     jack@suse.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
Message-ID: <20220209064338.vjhlaaav5dqb2hah@riteshh-domain>
References: <00000000000040c94205d78125af@google.com>
 <00000000000040b9d905d78e23ee@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000040b9d905d78e23ee@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Frvx_ob8aDwvqi30tsfaj1ukMDePQumB
X-Proofpoint-ORIG-GUID: Frvx_ob8aDwvqi30tsfaj1ukMDePQumB
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_03,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=714
 malwarescore=0 spamscore=0 bulkscore=0 clxscore=1011 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202090046
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/08 08:19PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    ef6b35306dd8 Add linux-next specific files for 20220204
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1390be28700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0431e0b00810b4f
> dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=133db2b4700000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17beb4a4700000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
>

#syz test: https://github.com/riteshharjani/linux.git jbd2-kill-t-handle-lock
