Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF6C5F9D3D
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Oct 2022 13:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiJJLCN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Oct 2022 07:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiJJLCL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Oct 2022 07:02:11 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4424862929;
        Mon, 10 Oct 2022 04:02:10 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29A9EpM6029113;
        Mon, 10 Oct 2022 11:01:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LNNRl1HMes1A3TXj5gRJGVjvRGGUQaqDkYr6eTBzjY0=;
 b=KKHezVlSYgFSJxJa+A7mlK/keSrGKQdDoVERyYoNZu4LdFZPgPNHovsL36bRSkKhKBDh
 QfioSpIV17BORYZHxVvvjZ20XYqIPf+G1ItydXMrxuSB5wzIh65/MWx7wx1Qw6VUSdpg
 /PDL4ETr7X+4Bl6np8WRM1v9noS9NM4Zzn7uK25NUevAz+Nf+lOJ5QOpNx9Q+iy/dtPy
 xfNgFaUMyNeyguWIN3fNIKry0zSenoW6gBsDZUYZeMRtSKgDc+gYJBh8ZJVc3x+uXS/Z
 JUPs9Ei+GKpAOj+O+RgustbWUugoql0VOibRN4LV06biPO3XZ158cIg0jmvxqETyBVYW gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k7v8ys1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:01:56 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29AAxrhi006353;
        Mon, 10 Oct 2022 11:01:55 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k3k7v8yqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:01:55 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29AAqp1O011332;
        Mon, 10 Oct 2022 11:01:53 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3k30u92nmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Oct 2022 11:01:53 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29AAvA6e45154760
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Oct 2022 10:57:10 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B234A405F;
        Mon, 10 Oct 2022 11:01:51 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0622FA405C;
        Mon, 10 Oct 2022 11:01:48 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.59.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Oct 2022 11:01:47 +0000 (GMT)
Date:   Mon, 10 Oct 2022 16:31:44 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ext4: remove deprecated_msg
Message-ID: <Y0P7mLFrS1ESZHqu@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20221009032520.108294-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221009032520.108294-1-jiapeng.chong@linux.alibaba.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: RspSoh1UrtrwZsVY0UdEtdi1vkIrtMjj
X-Proofpoint-GUID: ogxP67BBhI1AWc8jzbvX-KnnXKpigqiv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-10_06,2022-10-10_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210100063
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Oct 09, 2022 at 11:25:20AM +0800, Jiapeng Chong wrote:
> fs/ext4/super.c:1744:19: warning: ‘deprecated_msg’ defined but not used.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2346
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  fs/ext4/super.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 989365b878a6..7950904fbf04 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1741,10 +1741,6 @@ static const struct fs_parameter_spec ext4_param_specs[] = {
>  
>  #define DEFAULT_JOURNAL_IOPRIO (IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, 3))
>  
> -static const char deprecated_msg[] =
> -	"Mount option \"%s\" will be removed by %s\n"
> -	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
> -
>  #define MOPT_SET	0x0001
>  #define MOPT_CLEAR	0x0002
>  #define MOPT_NOSUPPORT	0x0004
> -- 
> 2.20.1.7.g153144c
> 

Hi,

I believe this is a duplicate of:
https://lore.kernel.org/all/20221004112114.101799-1-colin.i.king@gmail.com/

Regards,
ojaswin
