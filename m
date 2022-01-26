Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCA5C49C49F
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jan 2022 08:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiAZHiU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jan 2022 02:38:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10928 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229676AbiAZHiT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 26 Jan 2022 02:38:19 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20Q7WSE9005033;
        Wed, 26 Jan 2022 07:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=hdvhbb2jV5lKn9JGTFzMuv1jyH3Xr+Fz6n3lDspxOW8=;
 b=S7bC09JX07Cm5EOEoBkUBrjKQoX/jL9nbXArHLWPXoKs+8WVpxAkmwoT+eWV7YT8zp+n
 dT4mxwWMyJWDki45+J9s09fb2xh9blLQy47hmLye/rN0dKH2HXjycVGW0o/mycMvOsLQ
 /cVOkAnPhX/flap32AmgZaiypu8ZQYySUsXRtiMOpUdxwogxknhitttztDSWJQMU6yYD
 jrX48E/CnQ2uA3ViUnkCjI/G01hnoPqISZAFzoho+GH6ErmWpsehTQ9vIglKcoXkIGTC
 clCbq2vwNBGMsxWRPzl0BZVT1763Z/H0eqTMQnVOOyxTFy5bsTnbIXsQ542AOquvvnG6 dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtwa9vqyc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 07:38:12 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20Q7P3Eb010235;
        Wed, 26 Jan 2022 07:38:11 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dtwa9vqy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 07:38:11 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20Q7WPcA030562;
        Wed, 26 Jan 2022 07:38:10 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06ams.nl.ibm.com with ESMTP id 3dr96jm0fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 26 Jan 2022 07:38:10 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20Q7c7ga41681400
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 07:38:07 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA531A404D;
        Wed, 26 Jan 2022 07:38:07 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 692C8A4053;
        Wed, 26 Jan 2022 07:38:06 +0000 (GMT)
Received: from localhost (unknown [9.43.37.89])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 26 Jan 2022 07:38:06 +0000 (GMT)
Date:   Wed, 26 Jan 2022 13:08:04 +0530
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     Eryu Guan <eguan@linux.alibaba.com>
Cc:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org,
        Zhang Yi <yi.zhang@huawei.com>, tytso@mit.edu,
        Jan Kara <jack@suse.cz>, chenlong <chenlongcl.chen@huawei.com>
Subject: Re: [RFC 0/1] ext4/054: Should we remove auto and quick group?
Message-ID: <20220126073804.qtrzaru4v2dhgagm@riteshh-domain>
References: <cover.1643089143.git.riteshh@linux.ibm.com>
 <20220125074325.GB12255@e18g06458.et15sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125074325.GB12255@e18g06458.et15sqa>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EB6RnLuqBbw9-qZPfXr57wgGfzt_c7r2
X-Proofpoint-ORIG-GUID: TWlNsImm8ocwDbMypmOuYkqNScBELgG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=922 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260040
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/01/25 03:43PM, Eryu Guan wrote:
> On Tue, Jan 25, 2022 at 11:32:01AM +0530, Ritesh Harjani wrote:
> > Hello Zhang/Ted,
> >
> > Looks like the issue fixed by patches at [1], were observed with fault injection
> > testing and with errors=continue mount option. But were not cc'd to stable.
> >
> > Do you think those should be cc'd to stable tree?
> >
> > Meanwhile, I was thinking we should anyway remove auto and quick group from this
> > test as it could trigger a bug on in older kernel targets. Thoughts?
>
> IMO, ext4/054 is a targeted regression test and should be in auto group,
> which ensures the bug doesn't get re-introduced in future.

Yes, I agree with it.

>
> I think you could just skip this test to fit your kernel version, e.g.
>
> echo ext4/054 > ext4.exclude
> ./check -X ext4.exclude

Sure, thanks Eryu.

-ritesh
