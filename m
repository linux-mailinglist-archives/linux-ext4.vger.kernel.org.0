Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0469E4AEB4B
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 08:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238924AbiBIHmO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 02:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239253AbiBIHmH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 02:42:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD88C05CBAD;
        Tue,  8 Feb 2022 23:41:54 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2194W5l9007800;
        Wed, 9 Feb 2022 07:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=ZkXPI2UT9qn/sC6SAeCRIQEO8OPOyXOWYppUZ0LUOxQ=;
 b=CvXtTBlodxgIs1wGI6dc9SwRpcULYaZEEwt9dBxRT3vDqYCswO7PuaDolZcwEcjgY1on
 pj+i+MYq5DX+7fPsto23xbeaQcBLoY1eHEgsYOB13MlnUj20nUpG55kHk7yRCEHaXWS+
 XcoAMCXf5qHEfq9cyi3OAlvquhImu2EB1DTLFSWxm6fKXhQ315Q+nmzbpc6Ome5f3/xd
 lN5NKcUdHiMJIrKUj7CQl0ySiuxM+hkajlYOYr9I9jOrXIjXThYtqkDgrP6m0oH35e/G
 aFT8r5hJy/0HLEnqfNo+6eksq17iqtwUqNnywj0yIQBpRtvVVZB/Dc8A2XLYSsS0n3F5 4g== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e3tstdv08-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 07:41:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2197d4uA018757;
        Wed, 9 Feb 2022 07:41:42 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv9cbkb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Feb 2022 07:41:42 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2197fdVQ31392118
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Feb 2022 07:41:39 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABF575204E;
        Wed,  9 Feb 2022 07:41:39 +0000 (GMT)
Received: from localhost (unknown [9.43.124.244])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2CC625204F;
        Wed,  9 Feb 2022 07:41:38 +0000 (GMT)
Date:   Wed, 9 Feb 2022 13:11:37 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
Cc:     jack@suse.com, jack@suse.cz, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
Message-ID: <20220209074137.linx5qyi43hkclss@riteshh-domain>
References: <20220209064338.vjhlaaav5dqb2hah@riteshh-domain>
 <000000000000f3f46005d7905312@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000f3f46005d7905312@google.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EpAttfx4EXEZWiRKQRwp1t405Vz8ndiD
X-Proofpoint-GUID: EpAttfx4EXEZWiRKQRwp1t405Vz8ndiD
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-09_04,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 mlxlogscore=421 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090051
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/02/08 10:56PM, syzbot wrote:
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KASAN: use-after-free Read in jbd2_journal_wait_updates
>

#syz test: https://github.com/riteshharjani/linux.git jbd2-kill-t-handle-lock-t2
