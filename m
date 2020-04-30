Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853D51C0A6D
	for <lists+linux-ext4@lfdr.de>; Fri,  1 May 2020 00:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgD3W2S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 18:28:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51174 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgD3W2S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Apr 2020 18:28:18 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03UM3Dix115905;
        Thu, 30 Apr 2020 18:26:05 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mguyqwv6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 18:26:05 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 03UM3Jnm116164;
        Thu, 30 Apr 2020 18:26:05 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mguyqwug-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 18:26:05 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03UMKGgY027434;
        Thu, 30 Apr 2020 22:26:02 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 30mcu5uehb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 22:26:02 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03UMQ0nw57082034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 22:26:00 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46AC6AE051;
        Thu, 30 Apr 2020 22:26:00 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 805DEAE057;
        Thu, 30 Apr 2020 22:25:58 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.81.13])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 22:25:58 +0000 (GMT)
Subject: Re: [QUESTION] BUG_ON in ext4_mb_simple_scan_group
To:     linux-ext4@vger.kernel.org
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>, tytso@mit.edu, jack@suse.cz,
        dmonakhov@gmail.com, adilger@dilger.ca, bob.liu@oracle.com,
        wshilong@ddn.com
References: <9ba13e20-2946-897d-0b81-3ea7b21a4db6@huawei.com>
 <20200416183309.13914A404D@d06av23.portsmouth.uk.ibm.com>
 <39040d8c-9918-d976-a25a-0ec189f1e111@huawei.com>
 <20200417032644.75DF3A404D@d06av23.portsmouth.uk.ibm.com>
 <1740a49b-a10d-1bd3-a070-d76e9eb62fb2@huawei.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 1 May 2020 03:55:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1740a49b-a10d-1bd3-a070-d76e9eb62fb2@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200430222558.805DEAE057@d06av26.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_13:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300163
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

>>
>>> If above is true, then may be we should not call
>>> "SetPageUptodate(page)", in case of an error reading block bitmap?
>>> Thoughts?
>>>
>> Yeah, it's better to set page uptodate only if all block bitmap buffers
>> are uptodate represent by this page.
> 
> 
> So I guess the *easier* thing to do here is to abort the loop which
> calls ext4_wait_block_bitmap() in ext4_mb_init_cache, similar to how
> the loop above it does (which calls for ext4_read_block_bitmap_nowait())
> 
> Since if any of the block bitmap buffer (which belongs to that page)
> could not be read properly, then we should not set the PageUptodate.
> (including for blocksize < pagesize where groups_per_page > 1) and
> no need of even setting up the in memory buddy and bitmap information
> (since we are anyway not going to use it).
> 
> Others can comment, if something else needs to be done?
> But I think over optimizing this logic for blocksize < pagesize
> may become an overkill? (since this mostly happens during an I/O error).
> 

Ok, so as I see this bug was possibly introduced to handle blocksize < 
pagesize case itself [1]. So it will make no sense to just optimize it
for blocksize == pagesize again. So I guess we should look into this
more closely rather then simply implementing above logic.

[1]: https://www.spinics.net/lists/linux-ext4/msg48111.html

So, I can get back to this some time later maybe.

-ritesh
