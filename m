Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810E04CF157
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Mar 2022 06:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232386AbiCGFrB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Mar 2022 00:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiCGFrA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Mar 2022 00:47:00 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480357144
        for <linux-ext4@vger.kernel.org>; Sun,  6 Mar 2022 21:46:07 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22750BZY004002;
        Mon, 7 Mar 2022 05:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=i1dyMHfU/TEag9hCuT2DkXPd894y8ye+i+H44b9I4os=;
 b=J586Lzq/5Z6y/siN2yFkK4yja/MV7zt91MocFoJeHS4TV01HRa1jmJi/RAdnB3DE1Sx7
 /8B0O2FkPMEG2nVOmwR8Gu4hn+Fq0rpdmQ23oVrQOUak7BC9iAfLsipo2jLVUULAz1ss
 T/cbNCcdGWdmGZ/adElGPj61DQ5268u/NCHRpQLyTg9Wc47Ex3+7b+NOoFaSxDn87HVm
 crEX1q8XUlUh1dmC1sAI+rmG2MzFUGumBnRPhbOIvAGPFA0K9g8ON0qlOs3GQEtbtb5C
 CwsCcIdtQ10Yp//GmTtBob3mbwKMBfNOkOejO4LLLtsvnLjXcCSbboDNq9dkxGHw1Y+0 fQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3emt6tmya6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 05:46:03 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2275d28u003287;
        Mon, 7 Mar 2022 05:46:01 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3ekyg8upbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 05:46:01 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2275jxVG56164756
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Mar 2022 05:45:59 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65B1C42042;
        Mon,  7 Mar 2022 05:45:59 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E9C814203F;
        Mon,  7 Mar 2022 05:45:58 +0000 (GMT)
Received: from localhost (unknown [9.43.104.130])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Mar 2022 05:45:58 +0000 (GMT)
Date:   Mon, 7 Mar 2022 11:15:57 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Tadeusz Struk <tadeusz.struk@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: Re: BUG in ext4_ind_remove_space
Message-ID: <20220307054557.v4qqm4ushmm55v4y@riteshh-domain>
References: <48308b02-149b-1c47-115a-1a268dac6e24@linaro.org>
 <20220225171016.zwhp62b3yzgewk6l@riteshh-domain>
 <25749d7d-7036-0b71-3dd8-7b04dcc430e4@linaro.org>
 <346904fd-112a-8d57-9221-b5c729ea6056@linaro.org>
 <20220303145651.ackek7wotphg26gm@riteshh-domain>
 <995d8b3c-44ee-e190-42ae-75f2562b8d6b@linaro.org>
 <20220303200804.hugwhtqovxiutkfd@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220303200804.hugwhtqovxiutkfd@riteshh-domain>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0vAHiXmwJKUToPfZ7Bl5qP1P7Qxz8C8L
X-Proofpoint-GUID: 0vAHiXmwJKUToPfZ7Bl5qP1P7Qxz8C8L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_01,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 impostorscore=0 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=940 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203070033
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/03/04 01:38AM, Ritesh Harjani wrote:
> On 22/03/03 07:37AM, Tadeusz Struk wrote:
> > On 3/3/22 06:56, Ritesh Harjani wrote:
> > > On 22/03/02 03:14PM, Tadeusz Struk wrote:
> > > > On 2/25/22 11:19, Tadeusz Struk wrote:
> > > > > > I can verify this sometime next week when I get back to it.
> > > > > > But thanks for reporting the issue :)
> > > > >
> > > > > Next week is perfectly fine. Thanks for looking into it.
> > > >
> > > > Hi Ritesh,
> > > > Did you have chance to look into this?
> > > > If you want I can send a patch that fixes the off by 1 calculation error.
> > >
> > > Hi Tadeusz,
> > >
> > > I wanted to look at that path a bit more before sending that patch.
> > > Last analysis by me was more of a cursory look at the kernel dmesg log which you
> > > had shared.
> > >
> > > In case if you want to pursue that issue and spend time on it, then feel free to
> > > do it.
> > >
> > > I got pulled into number of other things last week and this week. So didn't get
> > > a chance to look into it yet. I hope to look into this soon (if no one else
> > > picks up :))
> >
> > I'm not familiar with the internals of ext4 implementation so I would rather
> > have someone who knows it look at it.
>
> No problem. I am willing to look into this anyways.
> btw, this issue could be seen easily with below cmd on non-extent ext4 FS.
>
> sudo xfs_io -f -c "truncate 0x4010040c000" -c "fsync" -c "fpunch 0x1000000 0xffefffff000" testfile

Just FYI - The change which we discussed to fix the max_block to max_end_block, is not correct.
Since it will still leave 1 block at the end after punch operation, if the file has s_bitmap_maxbytes size.
This is due to the fact that, "end" is expected to be 1 block after the end of last block.

Will try look into it to see how can we fix this.

1210 /**
1211  *      ext4_ind_remove_space - remove space from the range
1212  *      @handle: JBD handle for this transaction
1213  *      @inode: inode we are dealing with
1214  *      @start: First block to remove
1215  *      @end:   One block after the last block to remove (exclusive)
1216  *
1217  *      Free the blocks in the defined range (end is exclusive endpoint of
1218  *      range). This is used by ext4_punch_hole().
1219  */
1220 int ext4_ind_remove_space(handle_t *handle, struct inode *inode,
1221                           ext4_lblk_t start, ext4_lblk_t end)

-ritesh
