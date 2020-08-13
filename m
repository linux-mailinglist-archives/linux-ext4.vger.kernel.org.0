Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCEC24390B
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 13:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMLCY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 07:02:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36300 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726072AbgHMLCV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Aug 2020 07:02:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07DAWnaC088143;
        Thu, 13 Aug 2020 07:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding : message-id; s=pp1;
 bh=VieMsBgGfjr0AqhvrvmqDNh0sBv9wHO05ciIzTCGbUk=;
 b=h9aKHQtadn/z8/Wee0QYIlTJQvAQ92O9L5lq8pxXN2H6RGrtjPCly2jeKB6EmV4hWfcK
 PPgEALv6GG9d9OQ0ufmI9iSl3AdJk8HT5mFBhZ2pF60F2DwNp+NU1k2IIiuwd2NhNrSd
 4E6JwjAzVqXGPhO7O9JDypoBHl3XoYdXlWhiN5Ckm7TEFkQ8vZvJoJuzXG8py+RhNWA5
 4c0gm1+ekd84oyzuGEFgWMMuAI9mKR8fgg++3mokdO8POmqSva3+ZjTfdeJlO0LoopNk
 MwO7+dJLCtsg0Vm0shc4QE9i7gXa+H7+qChwv8igiE0Y8NfeSD9jBZlT30NkFHEv9uN9 AQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32vpam622c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 07:02:15 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 07DAWv8q088945;
        Thu, 13 Aug 2020 07:02:14 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32vpam60uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 07:02:14 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07DB0tVZ014255;
        Thu, 13 Aug 2020 11:01:35 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 32skp8dey1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Aug 2020 11:01:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07DB04PK59310586
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Aug 2020 11:00:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4FC34C04A;
        Thu, 13 Aug 2020 11:01:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1B794C05C;
        Thu, 13 Aug 2020 11:01:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.33.217])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 13 Aug 2020 11:01:30 +0000 (GMT)
Subject: Re: [PATCH v2] ext4: delete invalid ac_b_extent backup inside
 ext4_mb_use_best_found()
To:     Andreas Dilger <adilger@dilger.ca>, brookxu <brookxu.cn@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <0c77de22-c0d0-4c1b-645a-865bcd2edc0a@gmail.com>
 <B72B3282-4D45-41BB-8A39-66618C1CE69A@dilger.ca>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Thu, 13 Aug 2020 16:31:30 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <B72B3282-4D45-41BB-8A39-66618C1CE69A@dilger.ca>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200813110131.A1B794C05C@d06av22.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-13_06:2020-08-13,2020-08-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 clxscore=1011 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008130076
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 8/13/20 2:14 PM, Andreas Dilger wrote:
> On Aug 7, 2020, at 5:32 AM, brookxu <brookxu.cn@gmail.com> wrote:
>>
>> Delete invalid ac_b_extent backup inside ext4_mb_use_best_found(),
>> we have done this operation in ext4_mb_new_group_pa() and
>> ext4_mb_new_inode_pa().
> 
> I'm not sure I understand this patch completely.
> 
> The calls to ext4_mb_new_group_pa() and ext4_mb_new_inode_pa() are
> done from ext4_mb_new_preallocation(), which is called at the *end*
> of ext4_mb_use_best_found() (i.e. after the lines that are being
> deleted).
> 
> Maybe I'm confused by the description "we *have done* this operation"
> makes it seem like it was already done, but really it should be
> "we *will do* this operation in ..."?
> 
> That said, it would make more sense to keep the one line here in
> ext4_mb_use_best_found() and remove the two duplicate lines in
> ext4_mb_new_group_pa() and ext4_mb_new_inode_pa()?  In that case,
> the patch description would be more correct, like:
> 
>      Delete duplicate ac_b_extent backup in ext4_mb_new_group_pa()
>      and ext4_mb_new_inode_pa(), since we have done this operation
>      in ext4_mb_use_best_found() already.
> 

Looked into the mballoc code and I agree with Andreas points here.

-ritesh
