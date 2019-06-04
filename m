Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D02350A2
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jun 2019 22:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfFDUIy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jun 2019 16:08:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726261AbfFDUIy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jun 2019 16:08:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x54K8G4H065914
        for <linux-ext4@vger.kernel.org>; Tue, 4 Jun 2019 16:08:53 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2swvs6egu0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Tue, 04 Jun 2019 16:08:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 4 Jun 2019 21:08:51 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 4 Jun 2019 21:08:48 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x54K8l4Y47448096
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Jun 2019 20:08:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7DDFEA4040;
        Tue,  4 Jun 2019 20:08:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F0A2A4057;
        Tue,  4 Jun 2019 20:08:46 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Jun 2019 20:08:46 +0000 (GMT)
Subject: Re: possible deadlock in __do_page_fault (2)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     syzbot <syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, hdanton@sina.com, jmorris@namei.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, serge@hallyn.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Date:   Tue, 04 Jun 2019 16:08:45 -0400
In-Reply-To: <000000000000a7a51a058a728a6c@google.com>
References: <000000000000a7a51a058a728a6c@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19060420-4275-0000-0000-0000033CE1D0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19060420-4276-0000-0000-0000384CF220
Message-Id: <1559678925.4237.2.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-04_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=784 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906040127
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 2019-06-03 at 15:04 -0700, syzbot wrote:
> syzbot has bisected this bug to:
> 
> commit 69d61f577d147b396be0991b2ac6f65057f7d445
> Author: Mimi Zohar <zohar@linux.ibm.com>
> Date:   Wed Apr 3 21:47:46 2019 +0000
> 
>      ima: verify mprotect change is consistent with mmap policy
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16461c5aa00000
> start commit:   3c09c195 Add linux-next specific files for 20190531
> git tree:       linux-next
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=15461c5aa00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11461c5aa00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6cfb24468280cd5c
> dashboard link: https://syzkaller.appspot.com/bug?extid=606e524a3ca9617cf8c0
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10572ca6a00000
> 
> Reported-by: syzbot+606e524a3ca9617cf8c0@syzkaller.appspotmail.com
> Fixes: 69d61f577d14 ("ima: verify mprotect change is consistent with mmap  
> policy")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Thank you for the report.

Mimi

