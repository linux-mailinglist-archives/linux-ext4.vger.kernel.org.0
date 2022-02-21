Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4044BD7A5
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Feb 2022 09:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiBUIAL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Feb 2022 03:00:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238693AbiBUIAK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Feb 2022 03:00:10 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1833825EA
        for <linux-ext4@vger.kernel.org>; Sun, 20 Feb 2022 23:59:48 -0800 (PST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21L7IXoH028389;
        Mon, 21 Feb 2022 07:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : mime-version : content-type; s=pp1;
 bh=bBNparwPhURsBGia4YUQYMj+0StJ6QsvXHC2lL+Tz2A=;
 b=IHFgIOL1DSvWJM6i21CAnLXH9kJ5zdYCqgHTuJWbAAV4pkROUy60gOr7+LZzlwXUSQcW
 iB+sgTPZ3MkH0dSFzkSauiO2a7Qq93r3zN9c2DfeFKwXw2I0BSqv1md9Ej7ydfHlT3F0
 60Aj1xnXl0eqW6bEYGMvr7F4ab1guqv7iNU8CVmKu2tEvySVt0DUum0ZPcWFKzDPiUlr
 gHz2jSvJbk1dE6zAJCxcwEvxvglMvEMz//XjjRjXFH9wfnRYqv7bAzXLocXIrcqcMq3G
 /HSg3m3cbJbr7gt7YVYhlsj3j3kCYHNWCR/iK4FF10HTDf1k3wJkh6xFgAagpi7HNebu 8w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec67wrnwr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:59:44 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 21L7KMlt032296;
        Mon, 21 Feb 2022 07:59:44 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ec67wrnw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:59:44 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21L7wpOO016389;
        Mon, 21 Feb 2022 07:59:41 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3ear68rgcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 07:59:41 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21L7n5EA50004476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Feb 2022 07:49:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 754214C050;
        Mon, 21 Feb 2022 07:59:39 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A554C04E;
        Mon, 21 Feb 2022 07:59:39 +0000 (GMT)
Received: from localhost (unknown [9.43.127.119])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 21 Feb 2022 07:59:38 +0000 (GMT)
Date:   Mon, 21 Feb 2022 13:29:38 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: Query regarding fast_commit replay of inode
Message-ID: <20220221075938.g2lncbi7sxnnbrhr@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OBaW-fVr5U0T9GM5OVWNtyrR8_B05WZm
X-Proofpoint-ORIG-GUID: wyFACzNKqf7v-AkUeB06JfwqiXAa04VO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_02,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202210047
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Ted/Harshad,

I think we did discuss this once before, but I am unable to recollect the exact
reasoning for this. So question is - why do we have to call ext4_ext_clear_bb()
from ext4_fc_replay_inode()?

I was just thinking if this is suboptimal and if it can be optimized. But before
working on that problem, I wanted to again understand the right reasoning behind
choosing this approach in the first place.

Could you please help with this again?

ext4_fc_replay_inode()
<..>
	inode = ext4_iget(sb, ino, EXT4_IGET_NORMAL);
	if (!IS_ERR(inode)) {
		ext4_ext_clear_bb(inode);
		iput(inode);
	}
<..>

I will document it this time, so that I don't have to keep coming to this
everytime I look into fc replay code.

Thanks again for your help!!
-ritesh
