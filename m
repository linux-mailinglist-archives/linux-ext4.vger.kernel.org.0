Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED3A1BA6CE
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Apr 2020 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgD0Ops (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Apr 2020 10:45:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:5812 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727881AbgD0Ops (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Apr 2020 10:45:48 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03REViFL129372;
        Mon, 27 Apr 2020 10:45:39 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhr5q870-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 10:45:38 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03REjVQU015873;
        Mon, 27 Apr 2020 14:45:36 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu6v23d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Apr 2020 14:45:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03REjYpZ983396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 14:45:34 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AB4B11C050;
        Mon, 27 Apr 2020 14:45:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D54B011C058;
        Mon, 27 Apr 2020 14:45:33 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.43.36])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Apr 2020 14:45:33 +0000 (GMT)
Subject: Re: ext4 fiemap and the inode lock
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-ext4@vger.kernel.org
References: <20200427105032.GA27494@infradead.org>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Mon, 27 Apr 2020 20:15:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20200427105032.GA27494@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200427144533.D54B011C058@d06av25.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-27_10:2020-04-27,2020-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004270119
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Christoph,

On 4/27/20 4:20 PM, Christoph Hellwig wrote:
> Hi Ritesh,
> 
> before you converted ext4 to use iomap for fiemap, the indirect block
> case used generic_block_fiemap and thus took i_rwsem around the
> actual fiemap operation.  Do you remember if you did an audit if it
> was ok to drop it, or did that just slip in?

So, maybe since maybe the request was only to provide the block mapping
and since extent path didn't have it - so I may have not added it into
the indirect block case as well. Assuming both anyways uses same
-> i_data_sem lock. But I am not sure if it was deliberately dropped,
otherwise I would have noted that in my cover letter. So maybe it got
missed. But I will try and search in internal dev branches too, to see
if I could find anything related to that.

Thanks for noting that.

-ritesh


