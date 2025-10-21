Return-Path: <linux-ext4+bounces-11003-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5020ABF5C72
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 12:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93D0519810B0
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Oct 2025 10:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACA932BF20;
	Tue, 21 Oct 2025 10:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FLPYf9JZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB7224DD09;
	Tue, 21 Oct 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761042521; cv=none; b=Hae3pK01MeVZD4rEVtGE3VpimGt5Q21kGlvDrPE603iRMB3eJh113cn3OXpiJWxrQfH1rlU/33RBeu9D7ONNLaOsSa28Qu9yunYmfWbQ3ZZHq4DDIN6W4jacWWLylNJ8fDSC4HA7V2fxs9Zquzd/7gvxRX/7BKrtKMjO3JEUo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761042521; c=relaxed/simple;
	bh=o7nc+XDgyLdRWvYmxEANWXtoNQk5R7tRxzdB9KC/CFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jC9i5m9YsZnh2at5Z3HdF7sz3+evM1UXa2UL1GoCjByweh/KQ0JmyLu7/j7eADPCkh/Tlzetl1BU569ISJ8PDnZnOoUvdEXzEeknfPq4ThHh39Nnz4gfADHMmB+FTT7tnHym5PPTDIr8WCrsN0rp7oZ9KYiiUOcWiYe+m3khYZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FLPYf9JZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L4SbDt022756;
	Tue, 21 Oct 2025 10:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=VT/C0Fr+kXnD59/mEe08Khy2+AbO0a
	6cHOso556vaNM=; b=FLPYf9JZS8xm4wKz0FF0nZFj1JREj6M6EXQ1fCqQF2h4/P
	iefYwjXr7ISYXGYRJabY+JLZbX0N1p9gedzS8HTAFr/qMg2GpW3e9mKHbPvWsZvP
	JHH5y71e/oa5ee8lfc2aWKG+m2XJJrGKsoAUreQ+HrLf+7W7niKgI/D+1/CpA+/Y
	/xoV4/MpGbbbgEP5D1YYGokPj8Up5QjlTQKeOWG6ghymkIFn6Fye2dQwqSQ5MT3b
	Si4yUPxxjmegLjnowcMk+9+d31S6Lq/BJ93ndUjIMCPBpxYX+bKOP8paYSJpRe7D
	dRJ+2b5xPLnR0dNNMsBs1jTSohPb8RWaLndrr94g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rxeku-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 10:28:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LAMbWU009747;
	Tue, 21 Oct 2025 10:28:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31rxekq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 10:28:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L8akKU002488;
	Tue, 21 Oct 2025 10:28:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqeja1jb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 10:28:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59LASS7v38469984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 10:28:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C915920043;
	Tue, 21 Oct 2025 10:28:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FEA620040;
	Tue, 21 Oct 2025 10:28:26 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.23.251])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Oct 2025 10:28:26 +0000 (GMT)
Date: Tue, 21 Oct 2025 15:58:23 +0530
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: John Garry <john.g.garry@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org,
        Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        tytso@mit.edu, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v7 04/12] ltp/fsx.c: Add atomic writes support to fsx
Message-ID: <aPdgR5gdA3l3oTLQ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
References: <cover.1758264169.git.ojaswin@linux.ibm.com>
 <c3a040b249485b02b569b9269b649d02d721d995.1758264169.git.ojaswin@linux.ibm.com>
 <20250928131924.b472fjxwir7vphsr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aN683ZHUzA5qPVaJ@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251003171932.pxzaotlafhwqsg5v@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOJrNHcQPD7bgnfB@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20251005153956.zofernclbbva3xt6@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <aOPCAzx0diQy7lFN@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66470caf-ec35-4f7d-adac-4a1c22a40a3e@oracle.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: G-OJWBMuAYAUBAaFdpOdfRMyrOxpg6Da
X-Proofpoint-GUID: Uvia4lVAbIX9vhO5KO42c_Mu1cNgUJ9L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX8r/LRwdN3oBM
 ymWDMTWJImB/Ld8hA6NwNCZRdCSAVUjZrRXM8Phkc7NoM7Ym3rhdQDrASKRN4SWl/yu9yrvOYi6
 qHVXTfmXqooEnVYaQqBDAQ0TkyzJx6XOEUJl/JBxZ9P4VUOMd2baM1EdFHqTrMm5sPOJUqIFEj9
 8SOTxyuL7wpNNEtFmmYrkmJyMVC3HwAYwzI8t3ZGP/TMk4M/8eKLedhn58HYvO5Lid6LnCjtYrX
 kQuUuaoeoZMndfiCp50+lEYVvDdS6YP7CdyXWCrmBb45D7+q+QtTCJZ/z4BK082r/zw4IcnPrqf
 t2u7dCvcZ6UuLmmTpaNBfUHsftkKEYdJguSZIkY7SYd30QbkjYEXzpkuwXxEiAGRi5TnpSQD70r
 Jzep52Lp0tcsBFz/IrO/vACeP9ppFw==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f76050 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=Oo8esTTYCvExcNXu-J4A:9 a=CjuIK1q_8ugA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Mon, Oct 20, 2025 at 11:33:40AM +0100, John Garry wrote:
> On 06/10/2025 14:20, Ojaswin Mujoo wrote:
> > Hi Zorro, thanks for checking this. So correct me if im wrong but I
> > understand that you have run this test on an atomic writes enabled
> > kernel where the stack also supports atomic writes.
> > 
> > Looking at the bad data log:
> > 
> > 	+READ BAD DATA: offset = 0x1c000, size = 0x1803, fname = /mnt/xfstests/test/junk
> > 	+OFFSET      GOOD    BAD     RANGE
> > 	+0x1c000     0x0000  0xcdcd  0x0
> > 	+operation# (mod 256) for the bad data may be 205
> > 
> > We see that 0x0000 was expected but we got 0xcdcd. Now the operation
> > that caused this is indicated to be 205, but looking at that operation:
> > 
> > +205(205 mod 256): ZERO     0x6dbe6 thru 0x6e6aa	(0xac5 bytes)
> > 
> > This doesn't even overlap the range that is bad. (0x1c000 to 0x1c00f).
> > Infact, it does seem like an unlikely coincidence that the actual data
> > in the bad range is 0xcdcd which is something xfs_io -c "pwrite" writes
> > to default (fsx writes random data in even offsets and operation num in
> > odd).
> > 
> > I am able to replicate this but only on XFS but not on ext4 (atleast not
> > in 20 runs).  I'm trying to better understand if this is a test issue or
> > not. Will keep you update.
> 
> 
> Hi Ojaswin,
> 
> Sorry for the very slow response.
> 
> Are you still checking this issue?
> 
> To replicate, should I just take latest xfs kernel and run this series on
> top of latest xfstests? Is it 100% reproducible?
> 
> Thanks,
> John

Hi John,

Yes Im looking into it but I'm now starting to run into some reflink/cow
based concepts that are taking time to understand. Let me share what I
have till now:

So the test.sh that I'm using can be found here [1] which just uses an
fsx replay file (which replays all operations) present in the same repo
[2]. If you see the replay file, there are a bunch of random operations
followed by the last 2 commented out operations:

# copy_range 0xd000 0x1000 0x1d800 0x44000   <--- # operations <start> <len> <dest of copy> <filesize (can be ignored)>
# mapread 0x1e000 0x1000 0x1e400 *

The copy_range here is the one which causes (or exposes) the corruption
at 0x1e800 (the end of copy range destination gets corrupted).

To have more control, I commented these 2 operations and am doing it by
hand in the test.sh file, with xfs_io. I'm also using a non atomic write
device so we only have S/W fallback.

Now some observations:

1. The copy_range operations is actually copying from a hole to a hole,
so we should be reading all 0s. But What I see is the following happening:

  vfs_copy_file_range
   do_splice_direct
    do_splice_direct_actor
     do_splice_read
       # Adds the folio at src offset to the pipe. I confirmed this is all 0x0.
     splice_direct_to_actor
      direct_splice_actor
       do_splice_from
        iter_file_splice_write
         xfs_file_write_iter
          xfs_file_buffered_write
           iomap_file_buferred_write
            iomap_iter
             xfs_buferred_write_iomap_begin
               # Here we correctly see that there is noting at the
               # destination in data fork, but somehow we find a mapped
               # extent in cow fork which is returned to iomap.
             iomap_write_iter
              __iomap_write_begin
                # Here we notice folio is not uptodate and call
                # iomap_read_folio_range() to read from the cow_fork
                # mapping we found earlier. This results in folio having
                # incorrect data at 0x1e800 offset.

 So it seems like the fsx operations might be corrupting the cow fork state
 somehow leading to stale data exposure. 

2. If we disable atomic writes we dont hit the issue.

3. If I do a -c pread of the destination range before doing the
copy_range operation then I don't see the corruption any more.

I'm now trying to figure out why the mapping returned is not IOMAP_HOLE
as it should be. I don't know the COW path in xfs so there are some gaps
in my understanding. Let me know if you need any other information since
I'm reliably able to replicate on 6.17.0-rc4.

[1]
https://github.com/OjaswinM/fsx-aw-issue/tree/master

[2] https://github.com/OjaswinM/fsx-aw-issue/blob/master/repro.fsxops

regards,
ojaswin

