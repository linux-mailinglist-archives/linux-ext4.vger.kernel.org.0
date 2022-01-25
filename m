Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A093A49AC2A
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jan 2022 07:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235769AbiAYGKy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jan 2022 01:10:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53386 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238580AbiAYGCb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Jan 2022 01:02:31 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P5km0G006273;
        Tue, 25 Jan 2022 06:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=lCToaLxbJRfZkhhxLYTey5wBBBigPwYEHa3c6ZYVMDw=;
 b=hfhehMiWjPw2QJn95hAlEXBxWqelvmqNpVlvj0NXsiWAyAe2jn3ixwuUj94Gyug483Hv
 QrZ8FvXgKARYm5fkc4eNsvVMqSLsvPLxXa7qa3Ktlzk2/UkDRfNZTaiZJTCIvpX86T6R
 ZDQfhIY0t3VW9AJyMTX549/sx7W54S6dSOA+YqbxCyK5Dd+8N4LDHhdo8J2jDhnT/Q9I
 Nqd78z7IY7WT73W6CDuxfLoCPD+ubQvjgqvEmbpqzpXfNMkT7UJSWcJcAt660VDJj+cp
 Sd2vpAi0fvV3NqCOvy412Z2MZQYDD51GRrohbOfpNIXlyZ3lfgXeA/mdSfamkMsUguI6 cQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtbc0g91q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 06:02:12 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20P5xIt9030603;
        Tue, 25 Jan 2022 06:02:10 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06fra.de.ibm.com with ESMTP id 3dr96j9h1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 06:02:10 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20P6281e41615870
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 06:02:08 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 086994C044;
        Tue, 25 Jan 2022 06:02:08 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6A3CF4C052;
        Tue, 25 Jan 2022 06:02:07 +0000 (GMT)
Received: from localhost (unknown [9.43.18.116])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 06:02:07 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org
Cc:     Zhang Yi <yi.zhang@huawei.com>, tytso@mit.edu,
        Jan Kara <jack@suse.cz>, chenlong <chenlongcl.chen@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 0/1] ext4/054: Should we remove auto and quick group?
Date:   Tue, 25 Jan 2022 11:32:01 +0530
Message-Id: <cover.1643089143.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oJuTaWRAlKvEh3S4roz2tQMXk4yTpitq
X-Proofpoint-GUID: oJuTaWRAlKvEh3S4roz2tQMXk4yTpitq
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_01,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 mlxlogscore=706 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250040
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Zhang/Ted,

Looks like the issue fixed by patches at [1], were observed with fault injection
testing and with errors=continue mount option. But were not cc'd to stable.

Do you think those should be cc'd to stable tree?

Meanwhile, I was thinking we should anyway remove auto and quick group from this
test as it could trigger a bug on in older kernel targets. Thoughts?


[1]: https://lore.kernel.org/all/20210908120850.4012324-1-yi.zhang@huawei.com/

Ritesh Harjani (1):
  ext4/054: Remove auto and quick group

 tests/ext4/054 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
2.31.1

