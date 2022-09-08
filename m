Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617C05B16B9
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Sep 2022 10:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbiIHIS1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Sep 2022 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiIHIS0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Sep 2022 04:18:26 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15109083A
        for <linux-ext4@vger.kernel.org>; Thu,  8 Sep 2022 01:18:21 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2887ffMM013580;
        Thu, 8 Sep 2022 08:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=pp1; bh=0tkfSXZmvwurrBKMSSm1h5dTfHSFWJcv5/q6N1yf/0Q=;
 b=D87UQU+YCGX4cZ1+pahVkbDlFJAumfgP8YtFQjEKNih5bYIEoo3w9A5mpzrYw1MVnGhi
 zYHHdaP6AAWJs0Rg6i8t/CGm4j/TNLxOOaEmMynuukrVvsf/WKFWUZXSzx9LYUObP03B
 KXGF3O+zsWOITnQybnBVwREvAsINdaRmUOxmmhHdva2DtKWMvggE/4R6WGwpPXQ1cSP0
 CUXfntBeLfCBdN/d9rqfCLikp3qwH1eSZg5OR+EflX6yfxyc+On20VRp60vNQ2qQ53ln
 sa+0HQ2Qanpd7YLJxeCGUI6VtdjBvfla7xffyHEDo6DqHtazhC/b4lpVmI7cSXr19Ylc NA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jfc7s96y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:18:07 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28886Bb9028451;
        Thu, 8 Sep 2022 08:18:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3jbx6hp9gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Sep 2022 08:18:04 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2888I2Qs42598838
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 8 Sep 2022 08:18:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 470114203F;
        Thu,  8 Sep 2022 08:18:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEB1A42041;
        Thu,  8 Sep 2022 08:17:59 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.112.167])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  8 Sep 2022 08:17:59 +0000 (GMT)
Date:   Thu, 8 Sep 2022 13:47:56 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH 0/5 v2] ext4: Fix performance regression with mballoc
Message-ID: <YxmlNPMu58l9LTXU@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220906150803.375-1-jack@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906150803.375-1-jack@suse.cz>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NAwOGM4b4N_KZhar7Ce9XDaIqdjxUYOb
X-Proofpoint-ORIG-GUID: NAwOGM4b4N_KZhar7Ce9XDaIqdjxUYOb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_06,2022-09-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 adultscore=0 mlxlogscore=923 phishscore=0
 bulkscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209080028
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 06, 2022 at 05:29:06PM +0200, Jan Kara wrote:
> Hello,
> 
> Here is a second version of my mballoc improvements to avoid spreading
> allocations with mb_optimize_scan=1. The patches fix the performance
> regression I was able to reproduce with reaim on my test machine:
> 
>                      mb_optimize_scan=0     mb_optimize_scan=1     patched
> Hmean     disk-1       2076.12 (   0.00%)     2099.37 (   1.12%)     2032.52 (  -2.10%)
> Hmean     disk-41     92481.20 (   0.00%)    83787.47 *  -9.40%*    90308.37 (  -2.35%)
> Hmean     disk-81    155073.39 (   0.00%)   135527.05 * -12.60%*   154285.71 (  -0.51%)
> Hmean     disk-121   185109.64 (   0.00%)   166284.93 * -10.17%*   185298.62 (   0.10%)
> Hmean     disk-161   229890.53 (   0.00%)   207563.39 *  -9.71%*   232883.32 *   1.30%*
> Hmean     disk-201   223333.33 (   0.00%)   203235.59 *  -9.00%*   221446.93 (  -0.84%)
> Hmean     disk-241   235735.25 (   0.00%)   217705.51 *  -7.65%*   239483.27 *   1.59%*
> Hmean     disk-281   266772.15 (   0.00%)   241132.72 *  -9.61%*   263108.62 (  -1.37%)
> Hmean     disk-321   265435.50 (   0.00%)   245412.84 *  -7.54%*   267277.27 (   0.69%)
> 
> The changes also significanly reduce spreading of allocations for small /
> moderately sized files. I'm not able to measure a performance difference
> resulting from this but on eMMC storage this seems to be the main culprit
> of reduced performance. Untarring of raspberry-pi archive touches following
> numbers of groups:
> 
> 	mb_optimize_scan=0	mb_optimize_scan=1	patched
> groups	4			22			7
> 
> To achieve this I have added two more changes on top of v1 - patches 4 and 5.
> Patch 4 makes sure we use locality group preallocation even for files that are
> not likely to grow anymore (previously we have disabled all preallocations for
> such files, however locality group preallocation still makes a lot of sense for
> such files). This patch reduced spread of a small file allocations but larger
> file allocations were still spread significantly because they avoid locality
> group preallocation and as they are not power-of-two in size, they also
> immediately start with cr=1 scan. To address that I've changed the data
> structure for looking up the best block group to allocate from (see patch 5
> for details).
> 
> Stefan, can you please test whether these patches fix the problem for you as
> well? Comments & review welcome.
> 
> 								Honza
> Previous versions:
> Link: http://lore.kernel.org/r/20220823134508.27854-1-jack@suse.cz # v1

Hi Jan,

Thanks for the patch. I tested this series on my raspberry pi and I can
confirm that the regression is no longer present with both
mb_optimize_scan=0 and =1 taking similar amount of time to untar. The
allocation spread I'm seeing is as follows:
mb_optimize_scan=0: 10
mb_optimize_scan=1: 17 (Check graphs for more details)

For mb_optimize_scan=1, I also compared the spread of locality group PA
eligible files (<64KB) and inode pa files. The results can be found
here:

mb_optimize_scan=0:
https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2-mbopt0.png
mb_optimize_scan=1:
https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2.png
mb_optimize_scan=1 (lg pa only):
https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2-lgs.png
mb_optimize_scan=1 (inode pa only):
https://github.com/OjaswinM/mbopt-bug/blob/master/grpahs/patchv2-i.png

The smaller files are now closer together due to the changes to
locality group pa logic. Most of the spread is now coming from mid to
large files.

To test this further, I created a tar of 2000 100KB files to see if
there is any performance drop due to higher spread of these files and
notcied that although the spread is slightly higher(5BGs vs 9), we don't
see a performance drop while untarring with mb_optimize_scan=1.

Although we still have some spread, I think we have brought it down to a
much more manageable level and that combined with improvements to CR1
allocation have given us a good performance improvement.

Feel free to add:
Tested-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Regards,
Ojaswin
