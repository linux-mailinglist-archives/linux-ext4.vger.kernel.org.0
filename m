Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04C7D1A7132
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Apr 2020 04:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404223AbgDNCwU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Apr 2020 22:52:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48326 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404222AbgDNCwT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Apr 2020 22:52:19 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E2XB5J115096
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 22:52:18 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30b6tvccn3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 13 Apr 2020 22:52:18 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Tue, 14 Apr 2020 03:51:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 14 Apr 2020 03:51:57 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03E2qEaw44105892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Apr 2020 02:52:14 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 174C611C050;
        Tue, 14 Apr 2020 02:52:14 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 752F411C04A;
        Tue, 14 Apr 2020 02:52:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.32.26])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 14 Apr 2020 02:52:13 +0000 (GMT)
Subject: Re: generic/456 regression on 5.7-rc1, 1k test case
To:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
References: <20200413201211.wbcotcr6rg523wzs@localhost.localdomain>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 14 Apr 2020 08:22:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200413201211.wbcotcr6rg523wzs@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 20041402-0012-0000-0000-000003A40C06
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20041402-0013-0000-0000-000021E14095
Message-Id: <20200414025213.752F411C04A@d06av25.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-13_11:2020-04-13,2020-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1015 mlxlogscore=712
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140015
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Eric,

On 4/14/20 1:42 AM, Eric Whitney wrote:
> I'm seeing consistent failures for generic/456 while running kvm-xfstests' 1k
> test case on 5.7-rc1.  This is with an x86-64 test appliance root file system
> image dated 23 March 2020.
> 
> The test fails when e2fsck reports "inconsistent fs: inode 12, i_size is
> 147456, should be 163840".
> 
> Bisecting 5.7-rc1 identified the following patch as the cause:
> ext4: don't set dioread_nolock by default for blocksize < pagesize
> (626b035b816b).  Reverting the patch in 5.7-rc1 reliably eliminates the test
> failure.
> 

Since you could reliably reproduce it. Could you please try with this
patch and see if this fixes it for you?

https://patchwork.ozlabs.org/project/linux-ext4/patch/20200331105016.8674-1-jack@suse.cz/

-ritesh

