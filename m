Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DEC521431
	for <lists+linux-ext4@lfdr.de>; Tue, 10 May 2022 13:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241236AbiEJLxY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 May 2022 07:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiEJLxX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 May 2022 07:53:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB825E79C;
        Tue, 10 May 2022 04:49:26 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24AAfEGR011022;
        Tue, 10 May 2022 11:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=ARFuf21vSRs3SqQwRlCsfgFUIcJIjrwmZkD6ORueLl8=;
 b=TI8JJuG+TEz4MdFaLVhPHZXlgMR/+YzoOOiPzu6pyVdX+/fP1CO4Zq8phXlwie0VZksN
 x1gWDj93RSQqZiBZWMpFYIiYLnEe4I2baO4HRtkz3Jgd9tnSBmemof0w3Sp/rBq5EpPe
 12t6SC5FF1+namgvEsfhi7iWnSZNhK2W9/h3DC9gb4gS2ZCDpyrNFVJmuEp54xYTQcB+
 z6pQJvbLH3CHK+L5tWRAiPtK0cmANQn3uFkn6e0r20+t5fBYPjDWwwn7aUcTzHOCIMD5
 DJq0fT9/dhVvs+MmpG2U5xl3KS5u4hy8OW5y4dgmQJbWCsSXZISjhsgrerGHNzoOsb+a Dg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3fyncetet2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:49:25 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24ABnJkQ013231;
        Tue, 10 May 2022 11:49:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3fwgd8v0gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 May 2022 11:49:23 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24ABnLvG49217806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 May 2022 11:49:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9163611C04A;
        Tue, 10 May 2022 11:49:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0362011C04C;
        Tue, 10 May 2022 11:49:20 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.111.129])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 10 May 2022 11:49:19 +0000 (GMT)
Date:   Tue, 10 May 2022 17:19:16 +0530
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, riteshh@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] common/rc: Modify _require_batched_discard to improve
 test coverage
Message-ID: <YnpRPGBhFqFyPMUg@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
References: <20220401055713.634842-1-ojaswin@linux.ibm.com>
 <20220510063223.dogoows5t7cxpnul@zlang-mailbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510063223.dogoows5t7cxpnul@zlang-mailbox>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xx6_o-zgZKMJI-XrxxxF8-Z8Yod7k9DZ
X-Proofpoint-ORIG-GUID: xx6_o-zgZKMJI-XrxxxF8-Z8Yod7k9DZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_01,2022-05-10_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 mlxlogscore=897 malwarescore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205100052
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Zorro,

Thanks for the review.

On Tue, May 10, 2022 at 02:32:23PM +0800, Zorro Lang wrote:
> On Fri, Apr 01, 2022 at 11:27:13AM +0530, Ojaswin Mujoo wrote:
> > A recent ext4 patch discussed [1] that some devices (eg LVMs) can
> > have a discard granularity as big as 42MB which makes it larger
> > than the group size of ext4 FS with 1k BS. This causes the FITRIM
> > IOCTL to fail on filesystems like ext4.
> > 
> > This case was not correctly handle by "_require_batched_discard" as
> > it incorrectly interpreted the FITRIM failure as fs not supporting
> > the IOCTL. This caused the tests like generic/260 to incorectly
> > report "not run" instead of "failed" in case of large discard
> > granularity.
> > 
> > Fix "_require_batched_discard" to use a more accurate method
> > to determine if discard is supported.
> > 
> > [1] commit 173b6e383d2
> >     ext4: avoid trim error on fs with small groups
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  common/rc | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/common/rc b/common/rc
> > index e2d3d72a..97386342 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -3858,7 +3858,13 @@ _require_batched_discard()
> >  		exit 1
> >  	fi
> >  	_require_fstrim
> > -	$FSTRIM_PROG $1 > /dev/null 2>&1 || _notrun "FITRIM not supported on $1"
> > +
> > +	$FSTRIM_PROG $1 2>&1 | grep -q "not supported"
> > +	RET=$?
> 
> Better to use global variable carefully in common functions, if it's not
> necessary, I'd recommend using "local ret" at here.
Sure, I'll make the change.

> 
> From my experience, the *quiet (-q)* grep does "exit_on_match" directly,
> it won't wait the write process, if the write process is still writing but
> the grep has exited, then it'll cause broken pipe, and the write process
> exit with failure.
> 
> It doesn't always happend, it depends. So I'd like to use "${PIPESTATUS[1]}"
> or write it as 'grep -q "not supported" <($FSTRIM_PROG $1 2>&1)', to make sure
> we just care about the "grep" result.
Ah makes sense, will make this change as well.

Regards,
Ojaswin
> 
> > +	if [ "$RET" = "0" ]
> > +	then
> > +		_notrun "FITRIM not supported on $1"
> > +	fi
> >  }
> >  
> >  _require_dumpe2fs()
> > -- 
> > 2.27.0
> > 
> 
